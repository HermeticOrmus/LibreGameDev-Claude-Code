# Godot development pattern library

Reference patterns for Godot 4 development. Use as lookup when designing or reviewing Godot code.

## Signal vs. direct call decision

| Case | Choose |
|---|---|
| Emitter doesn't know listeners (achievement system, sound manager) | Signal |
| Emitter knows exactly one listener and the relationship is tight | Direct call |
| Multiple listeners with shared interest | Signal |
| Receiver needs to return a value to caller | Direct call |
| Order of execution matters | Direct call (signals are deferred by default) |
| Crossing scene boundaries | Signal (or autoload) |

Convention: signal names are past-tense verbs (`died`, `damaged`, `level_completed`).

## Resource sharing

The trap: `@export var config: ConfigResource` gives every instance the SAME resource. Modifying it affects all instances.

Safe patterns:

```gdscript
# Pattern A: Always duplicate
@onready var my_config: ConfigResource = config.duplicate()

# Pattern B: Make Unique in Inspector
# Right-click resource → Make Unique. Per-scene instance.

# Pattern C: Treat as immutable
# Document + discipline. Never write to config from runtime code.
```

## Input handling matrix

| Source | Use for |
|---|---|
| `Input.is_action_pressed("name")` in `_process` | Continuous input (movement) — but adds 1 frame latency |
| `Input.is_action_just_pressed("name")` in `_process` | One-shot input — same latency caveat |
| `_unhandled_input(event)` with `event.is_action_pressed("name")` | One-shot input with no latency |
| `_input(event)` with `event.is_action_pressed("name")` | Input that should ignore GUI focus |
| `_gui_input(event)` | UI input only (on Control nodes) |

## Physics body decision

| Body | Use when |
|---|---|
| `CharacterBody2D` / `CharacterBody3D` | Player or NPC under direct control |
| `RigidBody2D` / `RigidBody3D` | Object responds to physics forces |
| `RigidBody*` with `freeze_mode = KINEMATIC` | Want physics events but control velocity directly |
| `StaticBody*` | Immovable collider (wall, floor) |
| `AnimatableBody*` | Moving platform — animates but pushes RigidBody correctly |
| `Area2D` / `Area3D` | Trigger volume, no collision response |

## Common mistakes catalog

### "Physics is jittery"

Almost always `_process` instead of `_physics_process`. Variable timestep + physics = drift.

### "Input feels laggy"

`Input.is_action_pressed` in `_process` is one frame behind. For responsive actions, use `_unhandled_input`.

### "Modifying one enemy's HP changes all enemies"

Resource sharing. The HP value is in an `@export`ed `EnemyConfig` resource. Either `.duplicate()` it on `_ready()` or store HP in the Enemy node, not in the resource.

### "Signal fires too late / wrong order"

Signals are deferred (call_deferred semantics) when emitted from physics process. For immediate ordering, direct calls. For correct ordering across signals, use `await`:

```gdscript
emit_signal("event")
await get_tree().process_frame
# Now all listeners have processed
```

### "Camera2D doesn't follow player"

Camera2D needs `enabled = true` and to be a child of the moving body. Or use `set_make_current()` if multiple cameras exist.

### "Autoload script crashes on `get_node`"

Autoloads load before scenes. Getting nodes from a scene that doesn't exist yet fails. Either:
- Use signals for autoload → scene communication
- Defer the `get_node` until after `_ready()`

### "Scene I instantiated has wrong values"

You instantiated from a PackedScene resource. Edits to one instance don't affect the PackedScene. Conversely, edits to the PackedScene affect all future instances but not existing ones.

### "C# script doesn't see GDScript class"

GDScript classes are not visible to C# (and vice versa) until you use `class_name` for GDScript and the class is exported. Cross-language work requires explicit interfaces.

## Animation pattern card

| System | Use for |
|---|---|
| `AnimationPlayer` | Cutscenes, simple state transitions, UI animations |
| `AnimationTree` + `AnimationNodeStateMachine` | Character gameplay state (idle/walk/run/jump) |
| `AnimationTree` + `AnimationNodeBlendTree` | Blended animations (walk-aim with separate body parts) |
| `AnimationTree` + `AnimationNodeBlendSpace2D` | Directional blends (8-way walking) |
| `Tween` | UI transitions only (not characters) |

## GDScript ↔ C# rosetta

| GDScript | C# |
|---|---|
| `extends Node2D` | `: Node2D` (class declaration) |
| `@export var hp := 100` | `[Export] public int Hp = 100;` |
| `signal died` | `[Signal] public delegate void DiedEventHandler();` |
| `@onready var sprite = $Sprite2D` | Get in `_Ready()`: `_sprite = GetNode<Sprite2D>("Sprite2D");` |
| `func _ready():` | `public override void _Ready()` |
| `func _physics_process(delta):` | `public override void _PhysicsProcess(double delta)` |
| `await get_tree().process_frame` | `await ToSignal(GetTree(), SceneTree.SignalName.ProcessFrame);` |

## Project structure conventions

```
res://
├── scenes/        # PackedScene files (.tscn)
├── scripts/       # GDScript and C# files
├── resources/     # Custom Resources (configs, themes)
├── assets/        # Art, audio, fonts
│   ├── sprites/
│   ├── audio/
│   ├── fonts/
│   └── shaders/
├── autoloads/     # Singleton scripts (Project Settings → Autoload)
└── addons/        # Editor plugins
```

## Performance reference card

| Issue | Cost | Fix |
|---|---|---|
| Many `_process` scripts | Each is a method call per frame | Consolidate or use signal-driven updates |
| Many `_physics_process` scripts | Each is a method call per physics tick | Same as above |
| Drawing many sprites | Each is a draw call | MultiMeshInstance2D for repeated identical sprites |
| Many small Area2D | Each does a physics query | Combine queries; use raycast for one-shot |
| GDScript heavy loop | GDScript is interpreted | Move hot loop to C# or use bulk operations |
| String concatenation in loop | Allocates new String each time | StringBuilder pattern with PackedStringArray + join |

## Cross-references

- See `docs/02-core-game-concepts/` for game loop fundamentals
- See `docs/03-graphics-rendering/` for shader and particle patterns
- See `docs/06-networking-multiplayer/` for Godot's high-level multiplayer API
- See `docs/10-performance-optimization/` for profiling and frame-budget patterns
