# Intermediate — polish, juice, performance, save systems

You've made a prototype. It works. But the second one's tech debt is biting and you need a more disciplined approach. This path covers the polish layer between "prototype" and "demo-worthy."

## What you'll learn

- Why prototypes calcify into permanent tech debt
- How to add game feel ("juice") that makes games feel alive
- Performance optimization that actually moves the needle
- Save systems with versioning + migration
- When to refactor and when to ship as-is

## Path

### Phase 1 — Game feel (4-6 hours)

**Read:**
- [`docs/02-core-game-concepts/`](../docs/02-core-game-concepts/) — full section, focus on game-feel chapter
- [`docs/05-audio-systems/`](../docs/05-audio-systems/) — adaptive music + sound effects

**Then iterate on your prototype:**

```
/animation Walk me through adding juice to my 2D platformer. I want: squash-and-stretch on landing, screen shake on heavy hits, particle dust on running, slow-motion on critical hits, freeze-frame on impact, controller rumble.
```

The agent should give you a prioritized list. Start with screen shake + impact freeze (highest impact-to-effort ratio).

```
/audio Design the audio palette for my 2D platformer. Music should adapt to combat (start subdued, intensify during combat, resolve after). Sound effects should layer (footsteps + jumps + landings + ambient). Don't recommend specific assets — give me the design.
```

### Phase 2 — Performance optimization (3-5 hours)

**Read:**
- [`docs/10-performance-optimization/`](../docs/10-performance-optimization/) — full section in order

**Profile your prototype:**

```
/perf-game I built a prototype in Godot 4 (or Unity 6). It runs at 60 FPS on my machine but drops to 30 FPS on my older laptop. Where do I start optimizing?
```

The agent should insist on profiling before optimizing. Run the engine's profiler. Identify the actual bottleneck. Then optimize the bottleneck specifically.

Common bottleneck categories:
- Draw calls (batching helps)
- _process / Update method overhead (consolidation helps)
- Physics queries (spatial partitioning helps)
- GC allocations (pooling helps)
- Shader complexity (simplification helps)

### Phase 3 — Save systems (2-3 hours)

You'll need save / load for any non-arcade game.

**Read:**
- [`docs/02-core-game-concepts/`](../docs/02-core-game-concepts/) — state management + persistence chapters

**Implement:**

```
/save Design a save system for my 2D platformer. Requirements: player progress (level, items, stats), settings (audio, controls, graphics), profile-based (multiple profiles), versioned (so v1 saves still load after I update the game).
```

The agent should produce:
- Save format (JSON for human-readable + debuggable; binary for size-conscious)
- Versioning scheme + migration functions
- Profile system (separate save slots)
- Cloud-save consideration (Steam Cloud, etc.)

### Phase 4 — Refactor or ship? (1-2 hours)

The hardest discipline. When the prototype's architecture isn't right, do you refactor or ship?

**Read:**
- [`docs/09-advanced-patterns/`](../docs/09-advanced-patterns/) — ECS chapter (even if you don't use ECS, the thinking transfers)

**Talk to the architecture agent:**

```
/game-arch I have a prototype that works but feels structurally wrong. Spaghetti-style — many cross-references between systems. Player.gd directly modifies Enemy.gd state. Should I refactor or ship?
```

The agent should ask:
- How much further do you plan to take this prototype?
- Are you blocked on a specific feature because of the architecture?
- How big is the codebase?

Heuristic the agent applies: refactor when the architecture is blocking specific work; ship when the structural ugliness is just ugly but not blocking.

## What you've learned

By the end:

- Your prototype now has juice — it feels good to play, not just functional
- You've profiled and optimized at least one bottleneck
- You have a save system you can ship
- You can decide when to refactor vs. when to accept tech debt

## Common gotchas

1. **Adding juice everywhere** — too much screen shake feels like a tilt-a-whirl. Restraint.
2. **Premature pooling** — pool when you spawn > 30/sec; otherwise it's complexity for nothing.
3. **Premature ECS migration** — ECS for a 100-entity game is over-engineering.
4. **Forgetting save versioning** — every save format gets a version field from v1.0.0.

## Next: [Advanced path](advanced.md)

When you're ready to ship — really ship, not "release a demo on itch.io" — the advanced path covers multiplayer, telemetry, A/B testing, monetization ethics, and the platform-specific gotchas that turn launches into post-mortems.
