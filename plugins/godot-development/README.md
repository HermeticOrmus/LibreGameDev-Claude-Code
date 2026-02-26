# godot-development

Godot 4 plugin for LibreGameDev. Covers typed GDScript, scene/node architecture, signals, Resources, physics bodies, GDExtension, and GUT testing.

## Godot 4 vs Godot 3 Differences

| Feature | Godot 3 | Godot 4 |
|---------|---------|---------|
| Script language | GDScript 1.0 | GDScript 2.0 (typed, static) |
| Renderer | VisualServer | RenderingServer |
| Physics | PhysicsServer | PhysicsServer3D / 2D |
| Native extensions | GDNative | GDExtension |
| Signals | `connect("signal", self, "_on_signal")` | `signal_name.connect(_on_signal)` |
| Node references | `$` (untyped) | `@onready var n: Type = $Node` |
| Character movement | `move_and_collide()` | `move_and_slide()` with `velocity` property |

## Components

- **godot-developer**: Agent expert in Godot 4 GDScript, scene architecture, physics, signals, Resources, and GUT
- **godot**: Command for scene design, GDScript generation, GDExtension, and GUT testing
- **godot-patterns**: Skill library with typed GDScript templates, scene inheritance, autoloads, object pooling, signal-based components, and GUT tests

## Quick Start

Generate a character controller:
```
/godot script "CharacterBody3D third-person movement with jump and gravity"
```

Design a scene structure:
```
/godot scene "enemy character with health, detection area, and patrol"
```

Write GUT tests:
```
/godot test "HealthComponent damage, healing, and death signal"
```
