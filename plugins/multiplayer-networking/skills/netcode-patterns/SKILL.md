# Netcode Patterns

## Godot MultiplayerSynchronizer Setup

```gdscript
# Authoritative multiplayer character with MultiplayerSynchronizer
class_name NetworkedPlayer extends CharacterBody3D

@export var player_id: int = 0

# MultiplayerSynchronizer synchronizes these properties
# Configure in the Inspector on the MultiplayerSynchronizer node:
#   position: unreliable, always (smooth movement)
#   velocity: unreliable, always
#   health: reliable, on_change (critical state)
#   current_animation: reliable, on_change

@onready var sync: MultiplayerSynchronizer = $MultiplayerSynchronizer

func _ready() -> void:
    # Only process input for our own character
    set_physics_process(is_multiplayer_authority())

func _physics_process(delta: float) -> void:
    # Only runs on authority (local player or server)
    var input_dir := Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_back")
    velocity.x = input_dir.x * 6.0
    velocity.z = input_dir.y * 6.0
    if not is_on_floor():
        velocity.y -= 9.8 * delta
    move_and_slide()
    # MultiplayerSynchronizer broadcasts position/velocity to all peers automatically

# RPC call: client requests action, server validates and executes
@rpc("any_peer", "call_local", "reliable")
func request_attack(target_id: int) -> void:
    if not is_multiplayer_authority():
        return  # Only server processes this
    var target := get_node_or_null("/root/Game/Players/%d" % target_id)
    if target and _is_valid_target(target):
        _apply_damage.rpc(target_id, 10.0)

@rpc("authority", "call_local", "reliable")
func _apply_damage(target_id: int, amount: float) -> void:
    # Called on all clients from server authority
    if multiplayer.get_unique_id() == target_id:
        # Apply to self
        health -= amount
```

## Client-Side Prediction with Reconciliation

```gdscript
class_name PredictedPlayer extends CharacterBody3D
const MAX_PREDICTION_TICKS: int = 60  # 1 second buffer at 60Hz

# Input state snapshot for rollback
class InputSnapshot:
    var tick: int
    var input_vector: Vector2
    var jump_pressed: bool

# State snapshot for reconciliation
class StateSnapshot:
    var tick: int
    var position: Vector3
    var velocity: Vector3

var _pending_inputs: Array[InputSnapshot] = []
var _predicted_states: Array[StateSnapshot] = []
var _last_confirmed_tick: int = 0

func _physics_process(delta: float) -> void:
    var input := InputSnapshot.new()
    input.tick = multiplayer.get_remote_sender_id()  # Use tick counter
    input.input_vector = Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_back")
    input.jump_pressed = Input.is_action_just_pressed(&"jump")

    # Apply locally (prediction)
    _apply_input(input, delta)

    # Send to server
    _send_input_to_server.rpc_id(1, input.tick, input.input_vector, input.jump_pressed)

    # Store for reconciliation
    var state := StateSnapshot.new()
    state.tick = input.tick
    state.position = global_position
    state.velocity = velocity
    _predicted_states.append(state)
    _pending_inputs.append(input)

    # Trim old predictions
    while _predicted_states.size() > MAX_PREDICTION_TICKS:
        _predicted_states.pop_front()
        _pending_inputs.pop_front()

@rpc("authority", "call_local", "reliable")
func _receive_server_correction(confirmed_tick: int, server_position: Vector3, server_velocity: Vector3) -> void:
    # Find matching predicted state
    var mismatch_threshold := 0.1  # meters
    var predicted_state: StateSnapshot = null
    for state in _predicted_states:
        if state.tick == confirmed_tick:
            predicted_state = state
            break

    if not predicted_state:
        return

    if predicted_state.position.distance_to(server_position) > mismatch_threshold:
        # Reconciliation: rollback and re-simulate from confirmed state
        global_position = server_position
        velocity = server_velocity
        # Re-apply all unconfirmed inputs
        for input in _pending_inputs:
            if input.tick > confirmed_tick:
                _apply_input(input, 1.0 / 60.0)

    # Remove confirmed inputs
    _pending_inputs = _pending_inputs.filter(func(i): return i.tick > confirmed_tick)
    _predicted_states = _predicted_states.filter(func(s): return s.tick > confirmed_tick)

func _apply_input(input: InputSnapshot, delta: float) -> void:
    var direction := Vector3(input.input_vector.x, 0, input.input_vector.y).normalized()
    velocity.x = direction.x * 6.0
    velocity.z = direction.z * 6.0
    if not is_on_floor():
        velocity.y -= 9.8 * delta
    move_and_slide()
```

## Entity Interpolation for Remote Players

```gdscript
# Smooth remote player rendering with interpolation buffer
class_name InterpolatedRemotePlayer extends Node3D
const INTERPOLATION_DELAY: float = 0.1  # 100ms behind server time

class StateRecord:
    var timestamp: float
    var position: Vector3
    var rotation: Quaternion

var _state_buffer: Array[StateRecord] = []

func receive_state(position: Vector3, rotation: Quaternion) -> void:
    var record := StateRecord.new()
    record.timestamp = Time.get_unix_time_from_system()
    record.position = position
    record.rotation = rotation
    _state_buffer.append(record)
    # Keep buffer bounded
    if _state_buffer.size() > 20:
        _state_buffer.pop_front()

func _process(_delta: float) -> void:
    var render_time := Time.get_unix_time_from_system() - INTERPOLATION_DELAY

    # Find the two states surrounding render_time
    var prev: StateRecord = null
    var next: StateRecord = null

    for i in _state_buffer.size() - 1:
        if _state_buffer[i].timestamp <= render_time and _state_buffer[i + 1].timestamp >= render_time:
            prev = _state_buffer[i]
            next = _state_buffer[i + 1]
            break

    if prev and next:
        var t := (render_time - prev.timestamp) / (next.timestamp - prev.timestamp)
        global_position = prev.position.lerp(next.position, t)
        global_transform.basis = Basis(prev.rotation.slerp(next.rotation, t))
```

## Godot ENet Host/Client Setup

```gdscript
# Game session management
class_name NetworkManager extends Node
signal peer_connected(peer_id: int)
signal peer_disconnected(peer_id: int)
signal connection_failed

const DEFAULT_PORT: int = 28960
const MAX_PEERS: int = 8

func host_game(port: int = DEFAULT_PORT) -> void:
    var peer := ENetMultiplayerPeer.new()
    var error := peer.create_server(port, MAX_PEERS)
    if error != OK:
        push_error("Failed to create server: %d" % error)
        return
    multiplayer.multiplayer_peer = peer
    multiplayer.peer_connected.connect(_on_peer_connected)
    multiplayer.peer_disconnected.connect(_on_peer_disconnected)
    print("Hosting on port %d" % port)

func join_game(address: String, port: int = DEFAULT_PORT) -> void:
    var peer := ENetMultiplayerPeer.new()
    var error := peer.create_client(address, port)
    if error != OK:
        connection_failed.emit()
        return
    multiplayer.multiplayer_peer = peer
    multiplayer.connected_to_server.connect(_on_connected)
    multiplayer.connection_failed.connect(func(): connection_failed.emit())

func disconnect_game() -> void:
    if multiplayer.multiplayer_peer:
        multiplayer.multiplayer_peer.close()
    multiplayer.multiplayer_peer = null

func _on_peer_connected(peer_id: int) -> void:
    peer_connected.emit(peer_id)
    if multiplayer.is_server():
        _spawn_player_for_peer(peer_id)

func _on_peer_disconnected(peer_id: int) -> void:
    peer_disconnected.emit(peer_id)
    if multiplayer.is_server():
        _remove_player_for_peer(peer_id)

func _on_connected() -> void:
    print("Connected to server as peer %d" % multiplayer.get_unique_id())
```

## Anti-Patterns

- **Client-authoritative positions**: `rpc("any_peer")` to set position allows teleport hacks. Server sets positions; clients send inputs.
- **No jitter buffer**: Packets arrive out of order; applying immediately causes stutter. Buffer 2-4 ticks minimum.
- **Synchronizing `randf()` calls**: Random functions diverge across machines. Seed the RNG with network-synchronized seed and use deterministic sequence.
- **RPC every frame for all properties**: Use `MultiplayerSynchronizer` for frequent property sync. RPCs for one-time events only.
- **Trusting damage values from client**: `rpc_id(1, "apply_damage", 9999.0)`. Server always calculates damage from inputs, not from client-submitted values.
