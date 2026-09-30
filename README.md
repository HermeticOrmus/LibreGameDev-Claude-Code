<p align="center">
  <img src="https://ormus.solutions/mascot/pixellab_liquid_to_triforce.gif" alt="LibreGameDev Claude Code" width="128" style="image-rendering: pixelated;" />
</p>

<h1 align="center">LibreGameDev Claude Code</h1>

<p align="center">
  <em>Game development for Claude Code — 20 specialized plugins (20 agents, 20 commands, 20 skills) plus optional hooks, across Godot, Unity, Unreal, and web</em>
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

> **These game plugins also ship in [claude-code-game-development](https://github.com/HermeticOrmus/claude-code-game-development) v2.0.0**, which is where they keep growing. This pack stays installable as it is.

---

> **Skills, agents, commands, and a reference manual for shipping games with Claude Code.**

Game development is one of the few domains where the AI-codegen pattern that works for SaaS doesn't quite work. The game loop is timing-sensitive. The rendering pipeline is hostile to "just add abstraction." The state management is its own discipline. Generic LLM coding assistants often produce code that compiles but feels off — wrong physics, wrong feel, wrong feedback loop. **LibreGameDev gives Claude Code the game-specific expertise needed to ship games that feel right.**

Twenty domain plugins, each with an agent, a slash command, and a skill. Worked examples in GDScript, C# (Unity), C++ (Unreal), and Godot shader language. A 13-section reference manual, mostly JavaScript and web-focused, lives in the companion repo [claude-code-game-development](https://github.com/HermeticOrmus/claude-code-game-development/tree/main/docs). The substance you'd expect from a senior gameplay engineer who's also a Claude Code power user.

---

## The shift this kit responds to

Andrej Karpathy framed the broader change in December 2025:

> *"I've never felt this much behind as a programmer. The profession is being dramatically refactored."*

For game developers, the refactor cuts two ways. The tedious parts (boilerplate for input handlers, save serializers, asset import scripts) become faster. The expressive parts (game feel, player flow, level pacing) require deeper collaboration with the agent — and that means the agent needs deeper game-domain knowledge. **LibreGameDev provides that knowledge.**

### Where LibreGameDev fits in the Claude Code stack

| Claude Code component | LibreGameDev provides |
|---|---|
| **Plugins** | 20 domain plugins (engine, rendering, AI, audio, networking, more) plus the optional `libre-gamedev-hooks` |
| **Agents** | 20 specialist agents, one per plugin (Unity engineer, Godot engineer, network engineer, etc.) |
| **Commands** | 20 slash commands, one per plugin, each with focused actions |
| **Skills** | 20 pattern libraries, one per plugin |
| **Hooks** | Engine detection at session start, confirmation before touching secrets or signing keys, a check after writes |
| **Reference docs** | 13-section manual in [claude-code-game-development/docs](https://github.com/HermeticOrmus/claude-code-game-development/tree/main/docs) |
| **Templates** | A `CLAUDE.md` template for game projects (`templates/CLAUDE.md`) |

---

## What's included

```
LibreGameDev-Claude-Code/
├── .claude-plugin/
│   └── marketplace.json       # the libre-gamedev marketplace (21 plugins)
├── plugins/
│   ├── <plugin>/              # 20 game dev plugins, one per subdomain
│   │   ├── .claude-plugin/plugin.json
│   │   ├── agents/<agent>.md
│   │   ├── commands/<command>.md
│   │   ├── skills/<skill>/SKILL.md
│   │   └── README.md
│   └── libre-gamedev-hooks/   # optional hooks (hooks/hooks.json + scripts)
├── learning-paths/            # beginner / intermediate / advanced curated reading orders
├── templates/CLAUDE.md        # CLAUDE.md template for a game project
└── setup.sh                   # installs through the Claude Code plugin CLI
```

---

## The 20 plugins

Each plugin ships an **agent** (specialist persona), a **command** (quick slash invocation with focused actions), and a **skill** (reusable pattern library). Descriptions below match each plugin's manifest.

### Engines

| Plugin | Agent | Command | Skill | What it covers |
|---|---|---|---|---|
| **godot-development** | `godot-engineer` | `/godot` | `godot-development` | Node tree and scene design, signals, resources, physics, animation, typed GDScript or C#, GDExtension, and GUT tests. |
| **unity-development** | `unity-engineer` | `/unity` | `unity-development` | MonoBehaviour or DOTS architecture, URP and HDRP, Addressables, the Input System, ScriptableObjects, and idiomatic C#. |
| **unreal-engine** | `unreal-developer` | `/unreal` | `unreal-patterns` | Gameplay Framework, Blueprint or C++, the Gameplay Ability System, Enhanced Input, replication, and Lumen and Nanite. |

### Core systems

| Plugin | Agent | Command | Skill | What it covers |
|---|---|---|---|---|
| **game-architecture** | `game-architect` | `/game-arch` | `game-arch-patterns` | Game loops, ECS, event buses, data resources, service locators, scene management, and state stacks. |
| **input-systems** | `input-engineer` | `/input-system` | `input-patterns` | Action maps, gamepad deadzones, input buffering, rebinding, touch controls, and rumble across Godot, Unity, and Unreal. |
| **save-systems** | `save-system-engineer` | `/save-system` | `save-system-patterns` | Serialization, save file versioning and migration, atomic writes, slots, settings persistence, and platform cloud saves. |
| **localization** | `localization-engineer` | `/localize` | `localization-patterns` | String extraction, gettext PO files, ICU plurals, right-to-left layout, CJK font fallback, and pseudo-localization. |

### Rendering + audio

| Plugin | Agent | Command | Skill | What it covers |
|---|---|---|---|---|
| **shader-programming** | `shader-programmer` | `/shader` | `shader-patterns` | Godot shading language, vertex and fragment stages, common effects, post-processing, and shader performance. |
| **animation-systems** | `animation-engineer` | `/animate` | `animation-patterns` | Blend trees, state machines, IK, root motion, and animation events across Godot AnimationTree, Unity Animator, and Unreal AnimGraph. |
| **audio-systems** | `game-audio-engineer` | `/game-audio` | `audio-patterns` | Bus architecture, spatial audio, dynamic music, sound pooling, and FMOD or Wwise integration. |
| **ui-game-design** | `game-ui-designer` | `/game-ui` | `game-ui-patterns` | HUDs, menu stacks, inventory grids, dialogue boxes, settings screens, and accessibility with Godot Control nodes. |

### Gameplay

| Plugin | Agent | Command | Skill | What it covers |
|---|---|---|---|---|
| **ai-game-behavior** | `game-ai-engineer` | `/game-ai` | `game-ai-patterns` | Behavior trees, state machines, utility AI, GOAP, navmesh pathfinding, and perception systems. |
| **physics-simulation** | `physics-engineer` | `/physics` | `physics-patterns` | Body types, collision layers, character controllers, raycasts, triggers, joints, and physics performance in Godot and Unity. |
| **procedural-generation** | `procgen-engineer` | `/procgen` | `procgen-patterns` | Noise terrain, BSP and cellular automata dungeons, Wave Function Collapse, seeded randomness, and solvability checks. |
| **level-design** | `level-designer` | `/level-design` | `level-design-patterns` | Greyboxing, TileMaps, modular kits, navmesh baking, level streaming, and environmental storytelling. |

### Quality + ops

| Plugin | Agent | Command | Skill | What it covers |
|---|---|---|---|---|
| **playtesting** | `playtest-coordinator` | `/playtest` | `playtest-patterns` | Session design, observation protocols, telemetry schemas, death heatmaps, funnels, and A/B tests. |
| **performance-optimization** | `game-perf-engineer` | `/game-perf` | `game-perf-patterns` | Profiling methodology, draw call batching, LODs, occlusion culling, object pooling, and GDScript hot path fixes. |
| **asset-pipelines** | `asset-pipeline-engineer` | `/assets` | `asset-pipeline-patterns` | Import settings, texture atlasing, LOD generation, audio compression, and CI asset validation for Godot and Unity. |
| **multiplayer-networking** | `network-engineer` | `/multiplayer` | `multiplayer-networking` | Rollback, lockstep, client prediction with reconciliation, lag compensation, bandwidth budgets, NAT traversal, and Godot or Unity networking. |
| **monetization-ethics** | `monetization-advisor` | `/monetize` | `ethical-monetization-patterns` | Dark pattern audits, cosmetics-only stores, fair battle passes, platform IAP flows, and player spending protection. |

### Optional hooks

| Plugin | Events | What it does |
|---|---|---|
| **libre-gamedev-hooks** | `SessionStart`, `PreToolUse`, `PostToolUse` | Prints one line of context when the project is Godot, Unity, Unreal, or a web game; asks before a tool touches `.env` files, keys, Android keystores, or Godot export credentials, and before `rm -rf` or force pushes; flags empty writes and reminds once per session to run the tests. See [its README](plugins/libre-gamedev-hooks/README.md). |

---

## Quick start

### Install from Claude Code

```
/plugin marketplace add HermeticOrmus/LibreGameDev-Claude-Code
/plugin install godot-development@libre-gamedev
```

Install any other plugin the same way, by its name from the tables above plus `@libre-gamedev`. The same from a terminal:

```bash
claude plugin marketplace add HermeticOrmus/LibreGameDev-Claude-Code
claude plugin install godot-development@libre-gamedev
```

Optional hooks (engine detection, confirmation before touching secrets or signing keys): `/plugin install libre-gamedev-hooks@libre-gamedev`.

### Install from a checkout

```bash
# Clone
git clone https://github.com/HermeticOrmus/LibreGameDev-Claude-Code.git ~/projects/LibreGameDev-Claude-Code
cd ~/projects/LibreGameDev-Claude-Code

# Install all 21 plugins (the 20 game dev plugins plus libre-gamedev-hooks)
./setup.sh

# Or install just the plugins you need
./setup.sh --only godot-development,multiplayer-networking,shader-programming

# See every plugin, or remove the pack
./setup.sh --list
./setup.sh --uninstall
```

`setup.sh` registers the checkout as the `libre-gamedev` marketplace and installs through `claude plugin install`, so it needs the `claude` CLI and `jq`. Restart Claude Code after installing.

Then in any Claude Code session at your game project root:

```
/game-arch design an ECS-style architecture for a 2D space shooter in Godot 4 with 200+ simultaneous bullets, particle effects, and 6 enemy types
```

See [QUICK_START.md](QUICK_START.md) for a 30-minute walkthrough that takes you from "I cloned this" to "I have a working game prototype with Claude Code's help."

---

## The reference manual

The 13-section reference manual lives in [claude-code-game-development/docs](https://github.com/HermeticOrmus/claude-code-game-development/tree/main/docs): 80 files, each section a README plus topic chapters, with most examples in JavaScript for web games. Use as:

- **Lookup** when the agent says "I'd use a behavior tree here" and you want to read the full pattern
- **Onboarding** for new team members — point them at relevant sections in reading order via the learning paths
- **Reference for code review** when checking whether an agent-generated implementation follows known-good patterns

Highlights by section:

- **`03-graphics-rendering`**: canvas 2D rendering, WebGL basics, sprite management, lighting and shadows, particle systems, post-processing effects, shader programming
- **`04-game-ai`**: behavior trees, finite state machines, pathfinding, NPC behaviors, adaptive difficulty, procedural generation
- **`06-networking-multiplayer`**: client-server architecture, state synchronization, lag compensation, WebSocket implementation, matchmaking, anti-cheat
- **`09-advanced-patterns`**: entity-component systems, event-driven architecture, dependency injection, object pooling, spatial partitioning, save/load systems
- **`10-performance-optimization`**: profiling and debugging, rendering optimization, memory management, asset loading, mobile optimization, Web Worker parallelism

For rollback, lockstep, GOAP, and utility AI, the `multiplayer-networking` and `ai-game-behavior` plugins in this pack carry the patterns directly.

---

## Learning paths

The repo is structured by experience level. Each learning path is a **curated reading order through the [reference docs](https://github.com/HermeticOrmus/claude-code-game-development/tree/main/docs)**, paired with prompts for the plugins here, not separate content.

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

## Feedback

Starred this? Tell us what worked and what is missing: [open a feedback issue](https://github.com/HermeticOrmus/LibreGameDev-Claude-Code/issues/new?template=feedback.yml). Every piece of feedback gets an answer, and changes that come from it are credited in the release notes.

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

This repository is part of a growing family of open-source toolkits for Claude Code.

### Libre suite — comprehensive plugin bundles

- [LibreUIUX-Claude-Code](https://github.com/HermeticOrmus/LibreUIUX-Claude-Code) — UI/UX development (152 agents, 70 plugins, 76 commands, 74 skills)
- [LibreArch-Claude-Code](https://github.com/HermeticOrmus/LibreArch-Claude-Code) — Software architecture and system design
- [LibreCopy-Claude-Code](https://github.com/HermeticOrmus/LibreCopy-Claude-Code) — Technical writing and documentation engineering
- [LibreDevOps-Claude-Code](https://github.com/HermeticOrmus/LibreDevOps-Claude-Code) — DevOps engineering and infrastructure automation
- [LibreEmbed-Claude-Code](https://github.com/HermeticOrmus/LibreEmbed-Claude-Code) — Embedded systems, firmware, and IoT development
- [LibreFinTech-Claude-Code](https://github.com/HermeticOrmus/LibreFinTech-Claude-Code) — Financial technology development
- [LibreGEO-Claude-Code](https://github.com/HermeticOrmus/LibreGEO-Claude-Code) — AI-search optimization (ChatGPT, Perplexity, Gemini, Google AI Overviews)
- [LibreMLOps-Claude-Code](https://github.com/HermeticOrmus/LibreMLOps-Claude-Code) — ML engineering and AI operations
- [LibreMobileDev-Claude-Code](https://github.com/HermeticOrmus/LibreMobileDev-Claude-Code) — Mobile app development (Flutter, React Native, native iOS, native Android)
- [LibreSecOps-Claude-Code](https://github.com/HermeticOrmus/LibreSecOps-Claude-Code) — Security operations
- [LibreSessionFlow-Claude-Code](https://github.com/HermeticOrmus/LibreSessionFlow-Claude-Code) — Session lifecycle: handoff, pickup, absorb, explore, close

### Skills mini-repos — single CLAUDE.md drop-ins

- [vibe-engineer-skills](https://github.com/HermeticOrmus/vibe-engineer-skills) — Direct AI codegen well: hypothesis before help, scoped prompts, validate before accepting
- [markdown-discipline-skills](https://github.com/HermeticOrmus/markdown-discipline-skills) — Strip AI-slop from markdown (no em dashes, no marketing fluff)
- [shell-safety-skills](https://github.com/HermeticOrmus/shell-safety-skills) — `set -euo pipefail` discipline plus 15 failure-mode examples
- [commit-standard-skills](https://github.com/HermeticOrmus/commit-standard-skills) — Ormus Commit Standard v1.0 plus commit-msg hook and commitlint
- [unwoke-skills](https://github.com/HermeticOrmus/unwoke-skills) — Strip AI theater (ten sins to eliminate, symmetric engagement)
- [python-conventions-skills](https://github.com/HermeticOrmus/python-conventions-skills) — Modern Python 3.11+ (types, pathlib, async, ruff, mypy, uv)
- [typescript-conventions-skills](https://github.com/HermeticOrmus/typescript-conventions-skills) — TypeScript strict mode, discriminated unions, Result types
- [hermetic-laws-skills](https://github.com/HermeticOrmus/hermetic-laws-skills) — Seven Hermetic Principles applied to engineering
- [riper-workflow-skills](https://github.com/HermeticOrmus/riper-workflow-skills) — Research / Innovate / Plan / Execute / Review systematic dev
- [six-day-cycle-skills](https://github.com/HermeticOrmus/six-day-cycle-skills) — Sustainable shipping cadence with mandatory rest
- [token-optimization-skills](https://github.com/HermeticOrmus/token-optimization-skills) — Claude Code token and context optimization
- [osint-skills](https://github.com/HermeticOrmus/osint-skills) — OSINT research methodology (multi-wave investigative spiral)
- [calcinate-skills](https://github.com/HermeticOrmus/calcinate-skills) — Stage 1 of the Magnum Opus (burn project bloat)
- [claude-md-overhaul-skills](https://github.com/HermeticOrmus/claude-md-overhaul-skills) — Audit CLAUDE.md and MEMORY.md against caps
- [session-handoff-skills](https://github.com/HermeticOrmus/session-handoff-skills) — Session handoff and pickup discipline
- [naming-skills](https://github.com/HermeticOrmus/naming-skills) — Product naming methodology (mine the brand's vocabulary)
- [magnum-opus-skills](https://github.com/HermeticOrmus/magnum-opus-skills) — Seven-stage alchemy applied to project transformation
- [mem-search-skills](https://github.com/HermeticOrmus/mem-search-skills) — Search claude-mem cross-session memory: search, filter, fetch
- [hypothesis-debugging-skills](https://github.com/HermeticOrmus/hypothesis-debugging-skills) — Hypothesis-driven debugging: reproduce, isolate, test, fix
- [vibe-proof-skills](https://github.com/HermeticOrmus/vibe-proof-skills) — Security hardening for vibe-coded full-stack apps
- [tdd-skills](https://github.com/HermeticOrmus/tdd-skills) — Test-driven development (Red-Green-Refactor) for JS/TS and Python
- [mars-skills](https://github.com/HermeticOrmus/mars-skills) — Production-readiness audit: the five mortal sins of vibe-coded MVPs
- [git-workflow-skills](https://github.com/HermeticOrmus/git-workflow-skills) — Clean git workflow: branch, atomic commits, reviewable PRs
- [code-review-skills](https://github.com/HermeticOrmus/code-review-skills) — Domain-aware code review: classify the code, then focus
- [code-comprehension-skills](https://github.com/HermeticOrmus/code-comprehension-skills) — Understand an unfamiliar codebase fast
- [dx-audit-skills](https://github.com/HermeticOrmus/dx-audit-skills) — Audit developer experience: docs, onboarding, tooling friction
- [setup-env-skills](https://github.com/HermeticOrmus/setup-env-skills) — Set up a project's development environment
- [automate-skills](https://github.com/HermeticOrmus/automate-skills) — Turn repetitive tasks into reliable automation scripts
- [quick-fix-skills](https://github.com/HermeticOrmus/quick-fix-skills) — Fast troubleshooting for common issues
- [prime-context-skills](https://github.com/HermeticOrmus/prime-context-skills) — Prime project context at the start of a session
- [auto-docs-skills](https://github.com/HermeticOrmus/auto-docs-skills) — Generate and maintain project documentation
- [learning-skills](https://github.com/HermeticOrmus/learning-skills) — Learn any technology: roadmaps, explanations, practice, cheatsheets, comparisons
- [linux-sysadmin-skills](https://github.com/HermeticOrmus/linux-sysadmin-skills) — Linux system administration: security, performance, diagnostics, monitoring, maintenance

### Template source

- [andrej-karpathy-skills](https://github.com/HermeticOrmus/andrej-karpathy-skills) — the canonical single-file CLAUDE.md pattern (fork of jiayuan_jy's original)

Star the family, not just one — that's how the suite stays coherent.
