<p align="center">
  <img src="https://ormus.solutions/mascot/chain_braces_to_swan.gif" alt="LibreGameDev Claude Code" width="128" style="image-rendering: pixelated;" />
</p>

<h1 align="center">LibreGameDev Claude Code</h1>

<p align="center">
  <em>Game development with Claude Code — 20 specialized plugins, 13 reference sections, 80+ worked examples across Godot, Unity, Unreal, and web</em>
</p>

<p align="center">
  <a href="https://github.com/HermeticOrmus/LibreGameDev-Claude-Code/stargazers"><img src="https://img.shields.io/github/stars/HermeticOrmus/LibreGameDev-Claude-Code?style=flat-square&color=aa8142" alt="Stars" /></a>
  <a href="https://github.com/HermeticOrmus/LibreGameDev-Claude-Code/blob/main/LICENSE"><img src="https://img.shields.io/github/license/HermeticOrmus/LibreGameDev-Claude-Code?style=flat-square&color=aa8142" alt="License" /></a>
  <a href="https://github.com/HermeticOrmus/LibreGameDev-Claude-Code/commits"><img src="https://img.shields.io/github/last-commit/HermeticOrmus/LibreGameDev-Claude-Code?style=flat-square&color=aa8142" alt="Last Commit" /></a>
  <img src="https://img.shields.io/badge/Godot-aa8142?style=flat-square&logo=godotengine&logoColor=white" alt="Godot" />
  <img src="https://img.shields.io/badge/Unity-aa8142?style=flat-square&logo=unity&logoColor=white" alt="Unity" />
  <img src="https://img.shields.io/badge/Unreal-aa8142?style=flat-square&logo=unrealengine&logoColor=white" alt="Unreal" />
  <img src="https://img.shields.io/badge/Claude_Code-aa8142?style=flat-square&logo=anthropic&logoColor=white" alt="Claude Code" />
</p>

---

> **Skills, agents, commands, and a reference manual for shipping games with Claude Code.**

Game development is one of the few domains where the AI-codegen pattern that works for SaaS doesn't quite work. The game loop is timing-sensitive. The rendering pipeline is hostile to "just add abstraction." The state management is its own discipline. Generic LLM coding assistants often produce code that compiles but feels off — wrong physics, wrong feel, wrong feedback loop. **LibreGameDev gives Claude Code the game-specific expertise needed to ship games that feel right.**

Twenty domain plugins. Thirteen reference sections covering every layer from rendering to multiplayer. Worked examples in JavaScript, GDScript, C# (Unity), and C++ (Unreal). The substance you'd expect from a senior gameplay engineer who's also a Claude Code power user.

---

## The shift this kit responds to

Andrej Karpathy framed the broader change in December 2025:

> *"I've never felt this much behind as a programmer. The profession is being dramatically refactored."*

For game developers, the refactor cuts two ways. The tedious parts (boilerplate for input handlers, save serializers, asset import scripts) become faster. The expressive parts (game feel, player flow, level pacing) require deeper collaboration with the agent — and that means the agent needs deeper game-domain knowledge. **LibreGameDev provides that knowledge.**

### Where LibreGameDev fits in the Claude Code stack

| Claude Code component | LibreGameDev provides |
|---|---|
| **Plugins** | 20 domain plugins (engine, rendering, AI, audio, networking, more) |
| **Agents** | Specialist agents per plugin (Unity engineer, Godot engineer, network engineer, etc.) |
| **Commands** | Quick-access slash commands per plugin |
| **Skills** | Reusable pattern libraries per plugin |
| **Reference docs** | 13-section textbook with 80+ worked examples |
| **Templates** | Project scaffolds for Godot 4, Unity 6, Unreal 5, and Phaser/Pixi web games |

---

## What's included

```
LibreGameDev-Claude-Code/
├── 20 plugins                 # one per game-dev subdomain
├── docs/                      # 13-section reference manual (~1.8 MB)
│   ├── 01-getting-started
│   ├── 02-core-game-concepts
│   ├── 03-graphics-rendering
│   ├── 04-game-ai
│   ├── 05-audio-systems
│   ├── 06-networking-multiplayer
│   ├── 07-ui-ux
│   ├── 08-game-engines
│   ├── 09-advanced-patterns
│   ├── 10-performance-optimization
│   ├── 11-testing-qa
│   ├── 12-deployment-distribution
│   └── 13-case-studies
├── learning-paths/            # beginner / intermediate / advanced curated reading orders
└── templates/                 # project scaffolds per engine
```

---

## The 20 plugins

Each plugin ships an **agent** (specialist persona), a **command** (quick slash invocation), and a **skill** (reusable pattern library).

### Engines

| Plugin | Agent / Command | What it covers |
|---|---|---|
| **godot-development** | `/godot` | Godot 4 — GDScript + C#, Node tree, scene composition, signals, resource caching, physics, animation, project structure |
| **unity-development** | `/unity` | Unity 6 — C# scripting, MonoBehaviour vs. ECS/DOTS, Addressables, Render Pipelines (URP / HDRP), Cinemachine, Timeline |
| **unreal-engine** | `/unreal` | Unreal 5 — Blueprints + C++, Gameplay Framework, Niagara, Chaos physics, Lumen, Nanite, World Partition |

### Core systems

| Plugin | Agent / Command | What it covers |
|---|---|---|
| **game-architecture** | `/game-arch` | ECS vs. OOP, scene management, event systems, dependency injection in games, separation of simulation from rendering |
| **input-systems** | `/input` | Keyboard + mouse + controller + touch input, rebinding, dead zones, input buffering, fighting-game input parsing |
| **save-systems** | `/save` | Save formats (binary, JSON, custom), versioning + migration, cloud saves, save-state security |
| **localization** | `/localize` | i18n in games, RTL languages, font fallbacks, voice-over pipelines, regional content variations |

### Rendering + audio

| Plugin | Agent / Command | What it covers |
|---|---|---|
| **shader-programming** | `/shader` | HLSL + GLSL + Slang, lit + unlit shaders, post-processing, screen-space effects, shader graphs |
| **animation-systems** | `/animation` | Skeletal animation, blend trees, IK, root motion, additive layers, runtime retargeting |
| **audio-systems** | `/audio` | Spatialized audio, mixer + bus architecture, dynamic music systems, adaptive sound, FMOD + Wwise integration |
| **ui-game-design** | `/game-ui` | Diegetic vs. non-diegetic UI, controller-friendly menus, accessibility, in-world UI, retained-mode vs. immediate-mode |

### Gameplay

| Plugin | Agent / Command | What it covers |
|---|---|---|
| **ai-game-behavior** | `/game-ai` | Behavior trees, GOAP, FSMs, utility AI, navigation meshes, sensor systems, group behaviors |
| **physics-simulation** | `/physics` | Rigid body, soft body, cloth, fluids, raycasts, character controllers, deterministic physics for multiplayer |
| **procedural-generation** | `/procgen` | Wave Function Collapse, noise (Perlin/Simplex/Worley), L-systems, dungeon generation, terrain generation |
| **level-design** | `/level` | Whitebox to final, pacing, encounter design, environmental storytelling, level streaming |

### Quality + ops

| Plugin | Agent / Command | What it covers |
|---|---|---|
| **playtesting** | `/playtest` | Playtest planning, telemetry capture, heatmap analysis, A/B testing in games, retention funnels |
| **performance-optimization** | `/perf-game` | Frame budget analysis, draw call batching, occlusion culling, LODs, GPU profiling per engine, mobile-specific patterns |
| **asset-pipelines** | `/assets` | Import settings, atlasing, compression formats per platform, asset bundles, hot reload |
| **multiplayer-networking** | `/multiplayer` | Rollback netcode, lockstep, client-side prediction, lag compensation, dedicated server vs. P2P, matchmaking |
| **monetization-ethics** | `/monetize` | Ethical free-to-play patterns, IAP integration, ads SDK comparison, predatory pattern detection, regional regulations |

---

## Quick start

```bash
# Clone
git clone https://github.com/HermeticOrmus/LibreGameDev-Claude-Code.git ~/projects/LibreGameDev-Claude-Code
cd ~/projects/LibreGameDev-Claude-Code

# Install all 20 plugins into Claude Code
./setup.sh

# Or install just the plugins you need
./setup.sh --only godot-development,multiplayer-networking,shader-programming
```

Then in any Claude Code session at your game project root:

```
/game-arch design an ECS-style architecture for a 2D space shooter in Godot 4 with 200+ simultaneous bullets, particle effects, and 6 enemy types
```

See [QUICK_START.md](QUICK_START.md) for a 30-minute walkthrough that takes you from "I cloned this" to "I have a working game prototype with Claude Code's help."

---

## The reference manual

The `docs/` folder is a full 13-section reference covering the depth of modern game development. Each section has 5-8 in-depth files with code examples in multiple languages. Use as:

- **Lookup** when the agent says "I'd use a behavior tree here" and you want to read the full pattern
- **Onboarding** for new team members — point them at relevant sections in reading order via the learning paths
- **Reference for code review** when checking whether an agent-generated implementation follows known-good patterns

Highlights by section:

- **`03-graphics-rendering`** — canvas 2D rendering, lighting + shadows, particle systems (with object pooling), post-processing effects
- **`04-game-ai`** — behavior trees, adaptive difficulty, GOAP, utility AI, navmesh, perception systems
- **`06-networking-multiplayer`** — rollback netcode, lockstep determinism, client prediction, lag compensation, server authority models
- **`09-advanced-patterns`** — entity-component systems, data-oriented design, event sourcing in games, command pattern for undo
- **`10-performance-optimization`** — frame budget, draw call reduction, GPU profiling, mobile-specific optimizations

---

## Learning paths

The repo is structured by experience level. Each learning path is a **curated reading order through the reference docs**, not separate content.

### Beginner — *"I want to make my first game with Claude Code"*

You've never shipped a game. You want to understand the discipline before picking an engine. The beginner path walks you through core concepts (game loop, state, input handling) then a small first project.

→ [`learning-paths/beginner.md`](learning-paths/beginner.md)

### Intermediate — *"I have a game prototype that runs. Now what?"*

You've made something. It works. But it doesn't quite feel right and you're not sure why. The intermediate path covers the polish layer — feel, juice, pacing, performance basics, save systems.

→ [`learning-paths/intermediate.md`](learning-paths/intermediate.md)

### Advanced — *"I'm shipping. How do I avoid the disasters?"*

You're going to release. Now multiplayer netcode, real performance optimization, telemetry, A/B testing, monetization ethics, platform requirements (Steam, console certs), and the gotchas that turn launches into post-mortems.

→ [`learning-paths/advanced.md`](learning-paths/advanced.md)

---

## Compatibility

- **Engines covered**: Godot 4.x (GDScript + C#), Unity 2022.x / 6.x (C#), Unreal 5.x (Blueprints + C++)
- **Web game stacks**: Phaser 3, Pixi.js, plain Canvas + WebGL, Three.js (for 3D in web)
- **Languages**: JavaScript, TypeScript, GDScript, C#, C++
- **Platforms covered in deployment section**: Steam, itch.io, console (general patterns; no NDA-specific content), mobile (iOS/Android stores, regional compliance), web (deployment + monetization)
- **Skill level**: experienced programmers new to games (most useful) through senior gameplay engineers (still useful as a reference)

LibreGameDev plugins do not depend on any specific game engine being installed — the plugins are documentation + prompt-engineering, not engine-specific tooling.

---

## Contributing

Game dev is a wide field. Twenty plugins covers a lot but not everything. PRs especially welcome for:

- **Engine deepening** — Godot is currently most complete; Unity + Unreal need more
- **Genre-specific patterns** — roguelike, immersive sim, RTS, fighting game, MMO each have specialized knowledge
- **Mobile-specific patterns** — touch controls, battery optimization, app store review patterns
- **Console-specific patterns** — Switch, PlayStation, Xbox each have unique cert requirements (within NDA limits)
- **Translation** of learning paths — game dev community is heavily ESL; non-English documentation under-served
- **Case studies** of real shipped games with permission to discuss

See [CONTRIBUTING.md](CONTRIBUTING.md).

---

## Part of the Libre Open-Source Stack for Claude Code

LibreGameDev is one of a family of open-source toolkits for Claude Code, each focused on a specific lane. The sibling-cross-link block is appended below by the family-link maintainer.

---

## License

MIT © 2026 [Diego Bodart](https://github.com/HermeticOrmus) — see [LICENSE](LICENSE).
