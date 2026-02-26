# /multiplayer

Multiplayer networking: host/connect setup, state synchronization, client-side prediction, and debugging.

## Trigger

`/multiplayer [action] [target]`

## Actions

### `host`
Set up game hosting infrastructure.

```
/multiplayer host "Godot ENet co-op game for 2-8 players"
/multiplayer host "dedicated server with headless Godot instance"
/multiplayer host "Steam P2P lobby with relay fallback"
```

**Output**: NetworkManager GDScript, ENet/WebSocket configuration, player spawning on connect.

### `connect`
Implement client connection and session joining.

```
/multiplayer connect "lobby browser with LAN discovery"
/multiplayer connect "direct IP connect with port"
/multiplayer connect "Steam lobby join via invite"
```

**Output**: Client connection code, connection state machine, error handling for failed connections.

### `sync`
Design state synchronization for game objects.

```
/multiplayer sync "player position with client-side prediction"
/multiplayer sync "game state (score, round timer) authoritative broadcast"
/multiplayer sync "inventory items with reliable ordered delivery"
```

**Output**: MultiplayerSynchronizer configuration, RPC design, reliability mode selection.

### `debug`
Diagnose multiplayer bugs and desync issues.

```
/multiplayer debug "remote players teleporting on high latency"
/multiplayer debug "game desyncs after 2 minutes of play"
/multiplayer debug "host leaves and game crashes for all clients"
```

**Output**: Root cause analysis, fix code, testing methodology.

## Examples

**Client-side prediction for movement:**
```
/multiplayer sync "player movement with prediction for 100ms latency"
```
Produces: PredictedPlayer with input snapshot buffer, server correction RPC, reconciliation loop, entity interpolation for remote players.

**Diagnosing desync:**
```
/multiplayer debug "game desyncs: enemy health differs between clients after 30 seconds"
```
Checklist: Are all damage calculations server-authoritative? Are any values using randf() without synced seed? Is health sent as reliable property in MultiplayerSynchronizer?

**Setting up host migration:**
```
/multiplayer host "handle host leaving gracefully - migrate to another peer"
```
Produces: Peer ranking algorithm (oldest connection = next host), migration state machine, state handoff protocol.

## Tick Rate and Bandwidth Reference

| Tick Rate | Bandwidth/Player | Input Granularity | Genre Fit |
|-----------|-----------------|-------------------|----------|
| 10 Hz | Low | 100ms | Turn-based, strategy |
| 20 Hz | Medium | 50ms | MMO, casual co-op |
| 60 Hz | High | 16ms | Action RPG, shooter |
| 128 Hz | Very high | 7.8ms | Competitive FPS |

**RPC reliability modes:**
- `reliable`: TCP-like, guaranteed delivery, ordered. For: damage, deaths, inventory changes.
- `unreliable`: UDP, may drop, not ordered. For: position updates (latest wins anyway).
- `unreliable_ordered`: Latest delivery guaranteed, older dropped. For: animation state.
