# Beginner — your first game with Claude Code

You've never shipped a game. You want to understand the discipline before picking an engine, and you want Claude Code as your thinking partner. This path is a curated reading order through the reference docs, paired with hands-on prompts you'll run against the plugins.

## What you'll learn

- How game loops, state, and input differ from web/SaaS development
- Why object pooling matters for game performance
- The mental model for game architecture (entities, components, systems vs. scene tree composition)
- How to use the LibreGameDev agents productively
- Enough Godot 4 to ship a first prototype

## Path

### Phase 1 — Foundation (1-2 hours)

**Read:**
- [`docs/01-getting-started/`](../docs/01-getting-started/) — full section, in order
- [`docs/02-core-game-concepts/`](../docs/02-core-game-concepts/) — at minimum the game-loop and state-management chapters

**Then ask the `/game-arch` agent:**

```
/game-arch I'm new to game dev. I want to understand the core architectural patterns before picking an engine. Walk me through: game loop structure, state management, entity vs component vs system. Use 2D platformer as the running example.
```

The agent should walk you through fixed timestep, the update-render split, entity-component pattern, and signal-driven architecture. If it doesn't, the plugin install didn't work.

### Phase 2 — First prototype (3-5 hours)

**Pick an engine.** For beginners, Godot 4 is the gentlest entry. Unity is more job-relevant. Unreal is the most demanding. Don't optimize for resume — optimize for getting through your first prototype without bouncing.

**Walk the [QUICK_START.md](../QUICK_START.md)** in this repo. Build the 2D space shooter prototype. Don't skip steps.

**Read:**
- [`docs/03-graphics-rendering/canvas-2d-rendering.md`](../docs/03-graphics-rendering/canvas-2d-rendering.md) — even if you use an engine, the concepts transfer
- [`docs/03-graphics-rendering/particle-systems.md`](../docs/03-graphics-rendering/particle-systems.md) — pooling pattern shows up everywhere

### Phase 3 — Polish (2-3 hours)

Your prototype works. Now make it feel better.

**Read:**
- [`docs/02-core-game-concepts/`](../docs/02-core-game-concepts/) — game feel chapter
- [`docs/07-ui-ux/`](../docs/07-ui-ux/) — at minimum the controller-friendly UI patterns

**Then ask the `/animation` agent:**

```
/animation My 2D shooter feels stiff. The player shoots but there's no feedback — bullets just appear and enemies just disappear. Add: bullet muzzle flash, hit particles, screen shake on impact, damage numbers floating up from hit enemies.
```

These are "juice" techniques. They take 30 minutes of code to implement and they're the difference between "tech demo" and "game."

### Phase 4 — Beyond prototype (4+ hours)

Now you can decide if game dev is for you. Try one of:

**Option A — Genre exploration**: Build a different prototype in the same engine. Pick a different genre to stretch.

**Option B — Engine comparison**: Build the same prototype in a different engine. Compare the developer experience.

**Option C — Read deeper**: [`docs/09-advanced-patterns/`](../docs/09-advanced-patterns/) covers ECS, data-oriented design, command patterns. These patterns matter for shipping games at scale.

## What you've learned

By the end of this path:

- You've shipped a working game prototype with Claude Code's help
- You understand the architectural patterns that matter for games (pooling, fixed timestep, signal-driven, game feel)
- You can talk to a specific game engine (probably Godot) at intermediate level
- You can use LibreGameDev plugins productively
- You know whether you want to keep going

## Common gotchas

1. **Picking too ambitious a first project** — your first game should be small. A 2D shooter or platformer is hard enough.
2. **Skipping game feel** — without juice, the game feels broken even if the code is correct.
3. **Optimizing too early** — get the game working before profiling.
4. **Not testing on the target platform** — if you're building for mobile, run on mobile from Day 1.

## Next: [Intermediate path](intermediate.md)

When the first prototype runs, polish it, then read the intermediate path. It covers what to do when your second project's tech debt starts to bite.
