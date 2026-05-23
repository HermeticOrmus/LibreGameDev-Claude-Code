# Multiplayer networking pattern library

Reference patterns for game multiplayer netcode.

## Netcode model comparison

| Model | Best for | Latency tolerance | Bandwidth | Determinism required |
|---|---|---|---|---|
| **Rollback** | Fighting games | Very tight | Low | Yes |
| **Lockstep** | RTS, lockstep RTS | Tolerant | Very low | Yes |
| **Client prediction + reconciliation** | FPS, MOBA, action | Medium | Medium | No |
| **Server-authoritative + interpolation** | Racing, MMO movement | Tolerant | Medium-high | No |
| **Pure state snapshots** | Slow-paced games | Very tolerant | High | No |

## Common mistakes catalog

### "Rubber-banding when player runs forward"

The player's client predicts forward motion. Server agrees and confirms. No rubber-band. Then player turns; client predicts turn; server says "no, you didn't turn yet" because the turn input hadn't reached the server when the server's last tick fired. Server position is one tick behind; client snaps back.

Fix: smooth reconciliation. When server position differs from predicted, interpolate over 100-200ms rather than snapping.

### "I shot them dead-on and missed"

Favor-the-target policy. Server's "current" state is what counts; if your shot took 50ms to reach the server, the target may have moved. Either:
- Switch to favor-the-shooter (lag compensation)
- Use projectile weapons (the projectile travels in server time, no compensation needed)

### "I was shot around a corner"

Favor-the-shooter policy working as intended. The shooter saw you at their lag-compensated time; you've since moved behind cover. You're dead on the server before you visually see the threat.

Mitigation: limit lag compensation window (e.g., 100ms max, not 250ms).

### "Multiplayer works in lab, breaks on mobile data"

Mobile cellular has higher jitter and occasional packet loss. Check:

- Tick rate too high for cellular bandwidth budget
- No packet loss tolerance (UDP without reliability layer)
- No connection migration on IP change (mobile data → WiFi)
- Power-save modes throttling background packets

### "Desync after 30 seconds in lockstep RTS"

Nondeterminism. Audit:

- Float math anywhere in game state → switch to fixed-point
- RNG → seed at game start, use same RNG instance for all clients
- Iteration order over collections → use ordered collections (List, sorted Dictionary)
- Time-based logic → use tick count, not wall clock
- Third-party libraries → check determinism guarantees

### "Bandwidth balloons at high player counts"

Need interest management:

- Don't replicate everyone to everyone
- Each client subscribes to entities within its area of interest (visible + nearby)
- Cell-based partitioning or proximity-based subscription

### "Rollback budget exceeded constantly"

Either:
- RTT too high for the chosen input delay; increase input delay
- State serialization is too slow; profile + optimize
- Game state contains nondeterministic elements making rollback impossible

### "Players desync on resume from sleep / app backgrounding"

Game logic kept advancing while suspended (timer-based), or stopped while suspended (frame-based). Either way, syncing the resumed client requires state download from server.

Pattern: on resume, request full state from server before resuming play.

## Bandwidth optimization patterns

### Delta encoding

```
Frame N state:  position = (100, 50, 200), rotation = 45deg, hp = 80
Frame N+1 state: position = (101, 50, 200), rotation = 45deg, hp = 80

Naive send: position + rotation + hp = ~16 bytes
Delta send: position.x changed = 4-byte field + 4-byte value = 8 bytes

Savings: ~50%. Compounds with quantization.
```

### Quantization

- Position: from 32-bit float to 16-bit fixed-point (sub-mm precision over 1km range): 50% size reduction
- Rotation: from quaternion to compressed quaternion (smallest 3 + sign bit): 4 bytes → ~1.4 bytes
- Velocity: 8-bit per axis when bounded: 32 bytes → 3 bytes
- Time stamps: relative to a known epoch, 16-bit fits ~64 seconds at 1ms precision

### Bit packing

```
Boolean state flags: is_jumping, is_attacking, is_grounded, is_alive
Naive: 4 bytes (one per bool)
Packed: 1 byte (4 bits used, 4 bits header)

State enum (8 states): 1 byte → 3 bits
```

### Priority queues

When bandwidth budget is tight:

```
Priorities:
  Critical (must arrive every tick): player position, HP
  High (every 2-3 ticks): held weapon, ammo
  Medium (every 5-10 ticks): outfit, secondary stats
  Low (every ~100 ticks): emote, name, distant NPCs

Bandwidth-constrained: send only critical + as much high/medium as fits in budget
```

## Reconciliation smoothing

```csharp
private const float SMOOTHING_TIME = 0.15f; // 150ms
private Vector3 _renderOffset = Vector3.zero;

private void OnReconcile(Vector3 serverPosition)
{
    // Don't snap to serverPosition. Save the offset.
    _renderOffset = transform.position - serverPosition;
    transform.position = serverPosition;
}

private void LateUpdate()
{
    // Decay the offset over SMOOTHING_TIME
    _renderOffset = Vector3.Lerp(_renderOffset, Vector3.zero, Time.deltaTime / SMOOTHING_TIME);
    transform.position += _renderOffset; // Visual position uses offset; logical position is correct
}
```

## Library comparison (Unity)

| Library | Type | Maturity | Recommendation |
|---|---|---|---|
| **Netcode for GameObjects (NGO)** | First-party from Unity | Active | Default for new projects |
| **Mirror** | Open source, community-maintained | Mature | When NGO doesn't fit your model |
| **FishNet** | Open source, performance focus | Mature | When you need raw performance |
| **Photon Fusion** | Commercial, hosted | Mature | When you want hosted matchmaking + rooms |
| **Nakama** | Open source backend, multi-engine | Mature | When you want generic multiplayer backend |
| **PlayFab** | Microsoft commercial | Mature | Enterprise / live ops focus |
| **Edgegap** | Dedicated server hosting | Mature | When you need dedicated server scaling |

For Godot: built-in MultiplayerAPI is solid for small projects. Nakama for larger projects + backend services.

For Unreal: built-in networking + replication graph is industry-standard.

## NAT traversal reference

| Connection type | Strategy |
|---|---|
| Both peers same LAN | Direct connection |
| One peer has public IP | Direct to public peer |
| Both peers behind NAT (cone or restricted-cone) | STUN |
| Both peers behind symmetric NAT | TURN (relay through server) |
| ICE handles selection between STUN + TURN |

Steam's P2P API + Photon Cloud + Nakama all handle this for you. If self-hosting, integrate coturn (open source TURN server) or use Cloudflare's tier.

## Cross-references

- See `docs/06-networking-multiplayer/` for full reference manual: rollback, lockstep, prediction patterns
- See `docs/09-advanced-patterns/` for replication graph patterns
- See `docs/12-deployment-distribution/` for dedicated server hosting + matchmaking deployment
- See `monetization-ethics` plugin for ethical considerations in match-quality matchmaking
