# Beginner Learning Path - Game Development Fundamentals

## Overview

This path introduces game development from the ground up. You will understand the game loop, work with Godot Engine to build your first interactive project, and learn the fundamentals of sprites, input handling, and scene management. By the end, you will have a playable game and the mental model to build more complex ones.

## Prerequisites

- Basic programming knowledge (variables, functions, loops, conditionals)
- A computer that can run Godot 4.x (modest hardware requirements)
- Willingness to iterate: games are built through cycles of play, observe, adjust

## Modules

### Module 1: The Game Loop and Core Concepts

#### Concepts

- The game loop: the heartbeat of every game (input, update, render, repeat)
- Frame rate and delta time: why `_process(delta)` uses delta and what happens when you ignore it
- Game objects and scene trees: everything is a node, nodes compose into scenes, scenes compose into games
- Coordinate systems: screen space, world space, and why Y is often inverted in 2D
- Godot's node system: Node2D, Sprite2D, CharacterBody2D, Area2D, and when to use each
- Scenes as prefabs: reusable compositions of nodes (an enemy is a scene, a bullet is a scene)
- The difference between `_process()` and `_physics_process()`: frame-dependent vs physics-dependent
- Signals: Godot's observer pattern for decoupled communication between nodes
- GDScript basics: Python-like syntax, typed variables, `@onready`, `@export`

#### Hands-On Exercise

Set up Godot and explore the engine:

1. Download and install Godot 4.x (standard version, not .NET unless you need C#)
2. Create a new project. Explore the editor: Scene dock, Inspector, FileSystem, Output
3. Create a scene with a Sprite2D node. Assign a texture (any PNG image)
4. Attach a script to the sprite. Make it move right in `_process(delta)`:
   ```gdscript
   position.x += 100 * delta
   ```
5. Run the project and observe the sprite moving
6. Modify the script to wrap the sprite around when it exits the screen
7. Add a second sprite that moves vertically. Observe both running in the same game loop

Answer these questions: What happens if you remove `* delta`? Why does the sprite speed change?

#### Key Takeaways

- Delta time makes movement frame-rate independent: the game behaves the same at 30fps and 144fps
- Everything in Godot is a node; composition (nesting nodes) is how you build complexity
- The game loop runs every frame; your job is to describe what changes between frames

### Module 2: Sprites, Animation, and Input

#### Concepts

- Sprite sheets and AnimatedSprite2D: multiple frames in one image for smooth animation
- Animation states: idle, walk, jump, attack and transitioning between them
- Input mapping: binding physical keys to abstract actions (`ui_left`, `jump`, `attack`)
- Input handling patterns: polling (`Input.is_action_pressed`) vs events (`_input(event)`)
- The input map: Project Settings > Input Map for configurable, remappable controls
- Sprite flipping: `flip_h` for direction changes without duplicate art
- Z-index and draw order: controlling what renders in front of what
- Camera2D: following the player, setting limits, smooth scrolling
- Tilemaps: painting levels with reusable tiles instead of placing individual sprites

#### Hands-On Exercise

Build a character controller with animation:

1. Find or create a character sprite sheet (16x16 or 32x32 recommended, many free on itch.io)
2. Create a `CharacterBody2D` scene with:
   - `AnimatedSprite2D` with idle and walk animations
   - `CollisionShape2D` for physics interactions
3. Set up input actions in Project Settings: `move_left`, `move_right`, `move_up`, `move_down`
4. Write a movement script:
   ```gdscript
   extends CharacterBody2D

   @export var speed: float = 200.0

   func _physics_process(delta):
       var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
       velocity = direction * speed
       move_and_slide()

       if direction.x != 0:
           $AnimatedSprite2D.flip_h = direction.x < 0

       if direction.length() > 0:
           $AnimatedSprite2D.play("walk")
       else:
           $AnimatedSprite2D.play("idle")
   ```
5. Create a tilemap level with walls the player cannot walk through
6. Add a Camera2D that follows the player with smooth scrolling

Play the result. Adjust speed, animation frame rate, and camera smoothing until movement feels good. "Feels good" is subjective and requires iteration.

#### Key Takeaways

- Input mapping decouples physical buttons from game actions: always use actions, not raw key codes
- `move_and_slide()` handles collision response so you do not have to
- Game feel is in the details: acceleration, deceleration, animation timing all matter
- Use `_physics_process` for movement so physics behavior is consistent

### Module 3: Your First Complete Game

#### Concepts

- Game design scope: start absurdly small (one mechanic, one level, one enemy)
- The minimum viable game: a player, an obstacle, a goal, a fail state
- Scene management: switching between scenes (menu, game, game over)
- Signals for game events: `player_died`, `score_changed`, `level_completed`
- UI basics: Label for score, Control nodes for menus, CanvasLayer for HUD
- Collision detection: `Area2D` for triggers (pickups, damage zones), `CharacterBody2D` for physical collision
- Sound effects: `AudioStreamPlayer2D` for positional audio, `AudioStreamPlayer` for music
- Export: building your game for desktop (and later web, mobile)

#### Hands-On Exercise

Build a complete mini-game (pick one or invent your own):

**Option A: Top-down Collector**
- Player moves with WASD to collect items that spawn randomly
- Timer counts down from 30 seconds
- Score display shows collected items
- Game over screen with final score and restart button

**Option B: Side-scrolling Dodge**
- Player moves left/right and jumps to avoid obstacles scrolling from the right
- Obstacle speed increases over time
- Lives system (3 hits = game over)
- High score tracking

For whichever you choose:

1. Create separate scenes: `Main`, `Player`, `Obstacle`/`Collectible`, `HUD`, `GameOver`
2. Use signals to communicate between scenes (player emits `hit`, HUD listens)
3. Add at least two sound effects (pickup/collision) and background music
4. Create a main menu with a "Start" button
5. Export the game as a desktop build

Playtest with someone who did not build it. Watch them play without helping. Note every point of confusion.

#### Key Takeaways

- A finished small game teaches more than an unfinished ambitious one
- Playtesting reveals assumptions you did not know you were making
- Signals keep scenes independent: the player does not need to know the HUD exists
- Scope is the hardest skill in game development; practice finishing things

## Assessment

You have completed the beginner path when you can:

1. Explain the game loop and why delta time matters
2. Create a player character with movement, animation, and collision
3. Build a tilemap level with the player navigating through it
4. Use signals to connect game events without tight coupling
5. Ship a complete mini-game with menu, gameplay, and game-over states

## Next Steps

- Move to the **Intermediate Path**: state machines, physics, particles, audio, and UI systems
- Join the Godot community: Reddit, Discord, or the official forums
- Study games you admire: what makes the movement feel good? How does the UI communicate?
- Participate in a game jam (Ludum Dare, GMTK) to practice finishing under constraints
