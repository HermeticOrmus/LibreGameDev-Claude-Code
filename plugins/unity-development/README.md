# unity-development

Unity development plugin for LibreGameDev. Covers C# MonoBehaviour lifecycle, component architecture, ScriptableObject systems (event channels, item databases, game settings), Unity's new Input System, Rigidbody physics, Animator state machines, DOTS/ECS, Addressable Assets, and C# performance patterns.

## MonoBehaviour Lifecycle

```
Awake → OnEnable → Start → [FixedUpdate → Update → LateUpdate] → OnDisable → OnDestroy
```

| Method | Rule |
|--------|------|
| `Awake` | Cache `GetComponent`, self-init only |
| `Start` | Cross-component init (after all Awake) |
| `OnEnable`/`OnDisable` | Subscribe/unsubscribe events |
| `FixedUpdate` | All Rigidbody physics |
| `Update` | Input, visual updates |
| `LateUpdate` | Camera, IK post-processing |

## Components

- **unity-developer**: Agent with expertise in MonoBehaviour lifecycle, ScriptableObject architecture, new Input System, physics configuration, Animator, DOTS, and C# performance
- **unity**: Command for building scenes, designing ScriptableObject systems, implementing Input System, and debugging Unity-specific issues
- **unity-patterns**: Skill library with PlayerController (Rigidbody, FixedUpdate), ScriptableObject event channels (Ryan Hipple pattern), ItemDatabaseSO, new Input System integration with cached hashes, and generic ObjectPool<T>

## Quick Start

Create a character controller:
```
/unity scene "3D player: WASD movement, jump, sprint - rigidbody physics"
```

Set up event architecture:
```
/unity scriptable "game event channels: health changed, player died, level complete"
```

Implement input:
```
/unity input "new Input System player actions: move, jump, dash, attack"
```

## ScriptableObject Architecture

Prefer ScriptableObject-based architecture over singletons:
- **Event channels** instead of direct script references
- **Item/enemy definitions** instead of prefab-hardcoded values
- **Game settings** instead of PlayerPrefs scattered across scripts

See Ryan Hipple's "Game Architecture with Scriptable Objects" (Unite Austin 2017) for the full pattern.
