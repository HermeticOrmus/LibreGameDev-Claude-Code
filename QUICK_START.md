# Quick start

Thirty minutes from clone to a working game prototype with Claude Code as your co-pilot.

## What you'll build

A small 2D space-shooter prototype in Godot 4 with: player ship with WASD movement, mouse-aim, bullet pooling, three enemy types, particle effects on explosion, score tracking, and a game-over screen. The prototype won't ship but it will demonstrate the plugins working end-to-end on real code.

Why this matters: most "Claude Code for games" attempts fail because the agent doesn't know game-specific patterns (object pooling, frame-budget thinking, fixed timestep). This walkthrough proves the LibreGameDev plugins fix that.

## What you'll need

- Godot 4.2 or later installed ([godotengine.org](https://godotengine.org))
- Claude Code installed
- LibreGameDev plugins installed (see below)
- 30 minutes

If you prefer Unity or Unreal, the same walkthrough applies but you'd use `/unity` or `/unreal` instead of `/godot`. The agents understand the equivalent patterns in each engine.

## 1. Install plugins

```bash
git clone https://github.com/HermeticOrmus/LibreGameDev-Claude-Code.git ~/projects/LibreGameDev-Claude-Code
cd ~/projects/LibreGameDev-Claude-Code
./setup.sh
```

Restart Claude Code so it picks up the plugins.

## 2. Open a new Godot project

In Godot: New Project → name it "space-shooter" → create the project.

Open Claude Code in the project directory.

## 3. Design the architecture

```
/game-arch design a 2D space shooter in Godot 4. Requirements: player with WASD movement and mouse-aim, 200+ simultaneous bullets, 3 enemy types (drone, gunner, mine), particle effects on hit, simple score system. Aim for 60 FPS on a 5-year-old laptop.
```

Expected response:

- Recommendation of Node-tree structure (typically: `Main` root, `Player` with `Sprite2D + CollisionShape2D + Camera2D`, `EnemySpawner`, `BulletPool`, `ParticlePool`, `HUD`)
- Suggestion to use object pooling for bullets + particles (this is the game-arch agent's tell — it raises pooling proactively)
- Suggestion to separate simulation from rendering — `_physics_process` for game logic at 60Hz, `_process` for rendering
- A note on signals vs. direct references — when each is appropriate

If the response doesn't mention pooling for 200+ bullets, the plugin isn't installed correctly. Re-run `./setup.sh` + restart Claude Code.

## 4. Build the player

```
/godot write the Player scene script. Requirements: CharacterBody2D with WASD movement (200 px/s), mouse-aim (rotates to face cursor), shoots bullets on left-click (rate-limited to 5 per second), takes damage on enemy collision, dies at 0 HP.
```

Expected output:
- `player.gd` script with proper `_physics_process` for movement
- `_unhandled_input` for shoot input (not `_process` — important distinction)
- A `Timer` node or `clamp` on time accumulator for the 5/sec rate limit
- `look_at(get_global_mouse_position())` for mouse-aim
- A `take_damage(amount)` method
- Signal emission on death so other systems can react

Drop the script into Godot. Create the scene. Run.

## 5. Build the bullet pool

This is the moment the plugins really earn their keep. Without pooling, 200 bullets at 60 FPS is GC-pause hell.

```
/game-arch implement the BulletPool. 200 bullets max, instanced from a Bullet scene, reused on emission. Bullets should fire from player position toward mouse-aim direction, despawn after 2 seconds or on collision.
```

Expected output:
- A `BulletPool` Node that pre-instances 200 `Bullet` scenes at startup
- A `get_bullet()` method that returns a deactivated bullet and activates it
- Bullets self-deactivate after lifetime + return to pool
- Performance note: setting `process_mode = PROCESS_MODE_DISABLED` on inactive bullets saves frame time
- No `new()` calls during gameplay

Drop in, test. With pooling, 200 bullets should run smooth. Without it, you'd see hitches.

## 6. Build the enemies

```
/godot create three enemy types: Drone (slow chaser, 100 HP), Gunner (stops at 200px distance and shoots at player, 50 HP), Mine (stationary, explodes on player proximity, 200 HP).
```

Expected output:
- Three scene scripts with shared base class `Enemy` (extends CharacterBody2D)
- Each overrides `_physics_process` differently:
  - Drone: chase player with `move_and_slide`
  - Gunner: maintain distance + fire at player
  - Mine: idle + range detection + explosion
- Health + damage handling shared in base
- Death signal that the EnemySpawner can connect to

## 7. Add particle effects on hit

```
/animation add particle effects when bullets hit enemies. Use Godot's GPUParticles2D for an explosion effect. 50 particles per explosion, fade over 0.5 seconds, gravity-affected, varied colors (orange + yellow + red).
```

Expected output:
- A `HitParticles` scene with `GPUParticles2D` configured (not pooled — Godot's GPU particles are cheap)
- `ParticleProcessMaterial` settings: emission shape sphere, gravity, color ramp, scale curve
- A way to call `emit_particles_at(position)` from the Bullet's collision handler
- Note: if you spawn > 30 explosions per second, consider pooling — `/animation` will tell you the threshold

## 8. Add HUD + game over

```
/game-ui design the HUD. Show: score (top-left), player HP bar (top-center), bullet count (top-right). Plus a game-over screen with "Play Again" button on player death.
```

Expected output:
- HUD scene with `CanvasLayer` + child Control nodes
- Theme that's controller-friendly (large fonts, high contrast)
- Game-over Control with restart logic
- The note: Godot's `CanvasLayer` is what keeps the HUD on top of the game world; without it, HUD scrolls with the camera

## 9. Performance check

```
/perf-game I built the space shooter prototype. 200 bullets, 10 enemies, hit particles. Profile and tell me what's likely the bottleneck on a 5-year-old laptop.
```

Expected response — the agent should:
- Ask if you've actually profiled or are guessing (force measurement before optimization)
- Name the typical bottlenecks for a 2D Godot game (draw calls, _process overhead in many scripts, physics for high-count colliders)
- Suggest enabling the in-engine profiler (Debug → Monitor → Visible Profiler)
- Recommend `_physics_process` consolidation if many small scripts each have one

If the agent jumps to suggestions without asking you to measure first, the plugin isn't installed correctly.

## 10. What you've experienced

In 30 minutes you've used 5 different LibreGameDev agents to design and implement a game prototype that:

- Has correct architecture for the genre (pooling, signal-driven, separated sim/render)
- Performs well by default (60 FPS with pooling correctly applied)
- Demonstrates game-specific patterns the generic Claude Code wouldn't have suggested

This is the value the plugins add — not faster code, but **correct game code on the first try**.

## Iterating

The pattern across all 20 plugins is the same:

1. Describe what you need to the relevant agent
2. The agent produces a structured response with game-domain reasoning
3. You verify against your engine's reality
4. You implement, iterating with the agent for debug or refinement

## What's next

- **[Beginner path](learning-paths/beginner.md)** — curated reading order if you're new to games
- **[Intermediate path](learning-paths/intermediate.md)** — polish, juice, performance for your second prototype
- **[Advanced path](learning-paths/advanced.md)** — multiplayer, shipping, monetization, post-launch ops
- **[Reference docs](docs/)** — 13-section game dev manual, lookup-style

## Troubleshooting

- Agent gives generic answers, not game-specific → `./setup.sh` failed; re-run + verify, restart Claude Code
- `/godot` not recognized → plugins installed but Claude Code wasn't reloaded; restart Claude Code
- All commands work but agents are too brief → older Claude Code build; v1.x+ required for full agent mode

For other issues: [TROUBLESHOOTING.md](TROUBLESHOOTING.md).
