<p align="center">
  <h1 align="center">LibreGameDev-Claude-Code</h1>
</p>

<p align="center">
  <a href="#plugins"><img src="https://img.shields.io/badge/plugins-20-6c71c4?style=flat-square" alt="20 Plugins"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-6c71c4?style=flat-square" alt="MIT License"></a>
  <a href="#learning-paths"><img src="https://img.shields.io/badge/learning--paths-3-6c71c4?style=flat-square" alt="Learning Paths"></a>
  <a href="#hooks"><img src="https://img.shields.io/badge/hooks-3-6c71c4?style=flat-square" alt="3 Hooks"></a>
</p>

<p align="center">
A curated collection of Claude Code plugins for game development. From Godot to Unreal, procedural generation to multiplayer networking, shaders to save systems.
</p>

---

## Quick Start

1. Clone this repository into your project or reference it from your Claude Code configuration.
2. Copy the plugins you need into your project's `.claude/` directory.
3. Use slash commands (e.g., `/godot`, `/shader`, `/procgen`) to activate specific workflows.

```bash
# Clone the collection
git clone https://github.com/HermeticOrmus/LibreGameDev-Claude-Code.git

# Copy a plugin into your game project
cp -r LibreGameDev-Claude-Code/plugins/godot-development/ my-game/.claude/plugins/godot/
```

## Plugins

| # | Plugin | Description | Category |
|---|--------|-------------|----------|
| 1 | [ai-game-behavior](plugins/ai-game-behavior/) | NPC AI, behavior trees, finite state machines, utility AI | `ai` `gameplay` |
| 2 | [animation-systems](plugins/animation-systems/) | Sprite animation, skeletal animation, blend trees, state machines | `animation` `visual` |
| 3 | [asset-pipelines](plugins/asset-pipelines/) | Asset import, optimization, atlasing, LOD generation | `pipeline` `tooling` |
| 4 | [audio-systems](plugins/audio-systems/) | Sound design integration, music systems, spatial audio, audio buses | `audio` `immersion` |
| 5 | [game-architecture](plugins/game-architecture/) | Game loop design, ECS, component systems, scene management | `architecture` `core` |
| 6 | [godot-development](plugins/godot-development/) | GDScript, Godot nodes, scenes, signals, resources | `engine` `godot` |
| 7 | [input-systems](plugins/input-systems/) | Input mapping, controller support, rebinding, gesture recognition | `input` `controls` |
| 8 | [level-design](plugins/level-design/) | Level layout, tile maps, world building, environmental storytelling | `design` `world` |
| 9 | [localization](plugins/localization/) | Game text localization, translation workflows, cultural adaptation | `i18n` `text` |
| 10 | [monetization-ethics](plugins/monetization-ethics/) | Ethical monetization, fair F2P, cosmetics, no pay-to-win | `business` `ethics` |
| 11 | [multiplayer-networking](plugins/multiplayer-networking/) | Netcode, client-server, state sync, lag compensation | `networking` `multiplayer` |
| 12 | [performance-optimization](plugins/performance-optimization/) | Frame rate, draw calls, memory, profiling, LOD | `performance` `optimization` |
| 13 | [physics-simulation](plugins/physics-simulation/) | Rigidbody, collision, raycasting, joints, cloth physics | `physics` `simulation` |
| 14 | [playtesting](plugins/playtesting/) | Playtest planning, feedback collection, analytics, iteration | `testing` `feedback` |
| 15 | [procedural-generation](plugins/procedural-generation/) | PCG, noise functions, wave function collapse, dungeon generation | `procgen` `content` |
| 16 | [save-systems](plugins/save-systems/) | Save/load, serialization, cloud saves, data migration | `persistence` `data` |
| 17 | [shader-programming](plugins/shader-programming/) | Vertex/fragment shaders, visual effects, post-processing | `graphics` `shaders` |
| 18 | [ui-game-design](plugins/ui-game-design/) | Game UI/HUD, menus, inventory, dialogue systems | `ui` `ux` |
| 19 | [unity-development](plugins/unity-development/) | C# Unity, MonoBehaviour, ScriptableObjects, DOTS | `engine` `unity` |
| 20 | [unreal-engine](plugins/unreal-engine/) | Blueprints, C++ Unreal, Gameplay Framework, materials | `engine` `unreal` |

## Architecture

```
LibreGameDev-Claude-Code/
  plugins/
    {plugin-name}/
      README.md           # Plugin overview, usage, examples
      agents/
        AGENT.md          # AI agent persona definition
      commands/
        COMMAND.md         # Slash command specification
      skills/
        SKILL.md          # Knowledge base and patterns
  learning-paths/
    beginner.md           # First game, game loop basics
    intermediate.md       # State machines, physics, audio
    advanced.md           # ECS, networking, procgen, shaders
  hooks/
    session-start.sh      # Game engine detection
    pre-tool-use.sh       # Asset validation, safety checks
    post-tool-use.sh      # Build verification, perf alerts
  templates/
    CLAUDE.md             # Game dev project template
```

### Plugin Structure

Each plugin contains three components:

- **Agent** (`AGENT.md`): Defines a specialized AI persona with domain expertise, behavioral guidelines, and output format expectations.
- **Command** (`COMMAND.md`): Specifies a slash command trigger, expected input, processing steps, and structured output.
- **Skill** (`SKILL.md`): Captures patterns, anti-patterns, and reference knowledge for a specific game development domain.

### Hooks

Session lifecycle hooks that run automatically:

- **session-start.sh**: Detects the game engine in use (Godot, Unity, Unreal) and configures the session accordingly.
- **pre-tool-use.sh**: Validates assets and checks scene file safety before modifications.
- **post-tool-use.sh**: Verifies builds and alerts on performance regressions after changes.

## Learning Paths

Three progressive learning paths guide developers from first game to advanced systems:

| Path | Focus | Prerequisites |
|------|-------|---------------|
| [Beginner](learning-paths/beginner.md) | Game loop, sprites, input, first Godot game | Basic programming |
| [Intermediate](learning-paths/intermediate.md) | State machines, physics, particles, audio, UI | Beginner path |
| [Advanced](learning-paths/advanced.md) | ECS, networking, procgen, shaders, optimization | Intermediate path |

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on adding new plugins or improving existing ones.

## Code of Conduct

This project follows the [Contributor Covenant v2.1](CODE_OF_CONDUCT.md).

## License

[MIT](LICENSE) -- Copyright (c) 2025-2026 Hermetic Ormus


---

## Part of the Libre Open-Source Stack for Claude Code

This repository is part of a growing family of open-source toolkits for Claude Code, each focused on a specific lane:

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

Star the family, not just one — that's how the suite stays coherent.
