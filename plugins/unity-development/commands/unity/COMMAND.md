# /unity

Unity C# development: MonoBehaviour architecture, ScriptableObjects, Input System, physics, animation, and performance.

## Trigger

`/unity [action] [target]`

## Actions

### `scene`
Set up scene architecture and component structure.

```
/unity scene "player controller: movement, jump, ground check, coyote time"
/unity scene "enemy that patrols between waypoints and chases player on detection"
/unity scene "destructible crate: takes damage, breaks into physics debris"
```

**Output**: MonoBehaviour C# with `[RequireComponent]`, serialized fields, cached references, proper lifecycle methods (Awake/OnEnable/FixedUpdate).

### `scriptable`
Design ScriptableObject systems.

```
/unity scriptable "item database with item definitions and lookup by ID"
/unity scriptable "game event channels for health changed, player died, level complete"
/unity scriptable "enemy config: health, speed, damage, reward XP - reusable per enemy type"
```

**Output**: `[CreateAssetMenu]` ScriptableObject classes with typed properties, event channel pattern, usage example.

### `input`
Implement Input System integration.

```
/unity input "new Input System for player: move, jump, dash, attack"
/unity input "rebindable controls with save/load of player keybindings"
/unity input "device-agnostic UI navigation that works on both keyboard and controller"
```

**Output**: `PlayerInputActions` C# wrapper usage, OnEnable/OnDisable subscribe pattern, `ReadValue<T>` for continuous input.

### `debug`
Diagnose Unity-specific problems.

```
/unity debug "NullReferenceException on GetComponent in Awake"
/unity debug "Rigidbody jitters when moving up slopes"
/unity debug "animator parameter not updating correctly"
/unity debug "memory allocations spiking in Update loop - GC pressure"
```

**Output**: Root cause, fix code, explanation of Unity lifecycle or physics behavior causing the issue.

## Examples

**Player controller from scratch:**
```
/unity scene "3D character controller: WASD movement, jump with coyote time, sprint, rigidbody-based"
```
Produces: `PlayerController` MonoBehaviour with cached Rigidbody, `[SerializeField]` exposed stats, ground check via `Physics.CheckSphere`, movement in `FixedUpdate`, input in `Update`, coyote time timer.

**ScriptableObject event decoupling:**
```
/unity scriptable "health system: health changed event, player died event - no direct scene references"
```
Produces: `FloatEventSO` (health changed), `GameEventSO` (player died), `HealthComponent` MonoBehaviour that raises events, `HealthDisplay` that subscribes in `OnEnable` / unsubscribes in `OnDisable`.

## Lifecycle Reference

| Method | When | Use For |
|--------|------|---------|
| `Awake` | Object created (even if disabled) | Cache `GetComponent`, self-init |
| `OnEnable` | Object enabled | Subscribe to events |
| `Start` | First frame (after all Awake) | Cross-component init |
| `FixedUpdate` | Fixed physics tick (50Hz default) | Rigidbody forces, physics queries |
| `Update` | Every frame | Input, timers, visual updates |
| `LateUpdate` | After all Update | Camera follow, IK post-process |
| `OnDisable` | Object disabled | Unsubscribe from events |
| `OnDestroy` | Object destroyed | Cleanup |

## C# Quality Checklist

- [ ] `[SerializeField] private` (not `public`) for inspector-exposed fields
- [ ] All `GetComponent<T>()` calls in `Awake()`, stored in private fields
- [ ] Events subscribed in `OnEnable`, unsubscribed in `OnDisable`
- [ ] Physics in `FixedUpdate`, not `Update`
- [ ] No `new` in `Update` for objects - use pooling
- [ ] No LINQ in hot path - manual loops
- [ ] Layer masks from `LayerMask.GetMask("Name")`, not integer literals
