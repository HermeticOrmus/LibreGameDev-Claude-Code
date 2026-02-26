# /godot

Godot 4 development: scene setup, GDScript implementation, GDExtension, and GUT testing.

## Trigger

`/godot [action] [target]`

## Actions

### `scene`
Design or generate scene structure and node hierarchy.

```
/godot scene "third-person character with movement, health, and weapon"
/godot scene "enemy with detection area, patrol path, and health"
/godot scene "inventory UI with grid, item slots, and tooltip"
```

**Output**: Node tree diagram, recommended node types, @export and @onready declarations.

### `script`
Generate typed GDScript for a specific system or component.

```
/godot script "CharacterBody3D movement with coyote time and jump buffering"
/godot script "Area3D pickup with cooldown and respawn"
/godot script "Resource-based weapon data with fire rate and damage"
```

**Output**: Full typed GDScript with class_name, @export, signals, and inline comments.

### `extend`
GDExtension or plugin implementation for performance-critical code.

```
/godot extend "custom CharacterBody with advanced coyote time in C++"
/godot extend "editor plugin for tilemap auto-population"
/godot extend "visual profiler overlay using @tool script"
```

**Output**: GDExtension C++ skeleton with GDCLASS macro, or @tool GDScript for editor plugins.

### `test`
Write GUT unit tests for a component or system.

```
/godot test "HealthComponent with damage, healing, death signal, and overkill"
/godot test "StateMachine transition table with event dispatch"
/godot test "Inventory add/remove/stack item operations"
```

**Output**: GUT test class with before_each, test_ methods, signal watching, and edge cases.

## Examples

**CharacterBody3D movement with all game feel features:**
```
/godot script "CharacterBody3D with coyote time, jump buffering, and variable jump height"
```
Produces: Typed GDScript with:
- Coyote time (2-frame grace period after leaving ledge)
- Jump buffer (0.1s pre-input window before landing)
- Variable jump height (release early = shorter jump, via gravity multiplier)
- Acceleration/friction curves for responsive feel

**Resource-based item system:**
```
/godot script "ItemData Resource with rarity, stats, icon, and stack size"
```
Produces: `class_name ItemData extends Resource` with @export fields, stat modifiers array, Rarity enum, and validation.

**GUT test for save system:**
```
/godot test "SaveSystem serializes and deserializes player state correctly"
```
Produces: GUT test with temporary file creation, save/load roundtrip assertion, version migration test.

## GDScript Quality Checklist

Before shipping any GDScript:
- [ ] Every variable has a type annotation
- [ ] Every function has a return type (`-> void`, `-> float`, etc.)
- [ ] `class_name` declared if reusable as a type
- [ ] Signal names are snake_case past-tense verbs
- [ ] No bare `get_node()` calls outside `_ready()`
- [ ] `@onready` used for all child node references
- [ ] Hot paths (`_physics_process`) have no dynamic typing or string lookups
