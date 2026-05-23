# Changelog

## [0.2.0] — 2026-05-23

Major content depth pass. 20 plugin shells filled with the LibreUIUX template chrome plus a 1.8 MB reference manual (docs/) imported from sibling repo for genuine game-dev expertise. Three flagship plugins promoted to depth-complete.

### Added

- 1.8 MB reference manual imported from prior sibling repo as `docs/`:
  - `01-getting-started` (6 files)
  - `02-core-game-concepts` (8 files)
  - `03-graphics-rendering` (8 files) — canvas 2D, lighting + shadows, particle systems, post-processing
  - `04-game-ai` (7 files) — behavior trees, adaptive difficulty, GOAP, utility AI
  - `05-audio-systems` (5 files)
  - `06-networking-multiplayer` (7 files) — rollback, lockstep, prediction
  - `07-ui-ux` (6 files)
  - `08-game-engines` (7 files)
  - `09-advanced-patterns` (7 files) — ECS, data-oriented design
  - `10-performance-optimization` (7 files)
  - `11-testing-qa` (5 files)
  - `12-deployment-distribution` (6 files)
  - `13-case-studies` (1 file)
- 3 flagship plugins promoted to depth-complete:
  - `godot-development` — Godot 4 specialist with GDScript + C#, Node tree, signals, resources, physics
  - `unity-development` — Unity 6 specialist with C#, MonoBehaviour vs. ECS/DOTS, Addressables, Render Pipelines
  - `multiplayer-networking` — Rollback netcode, lockstep determinism, client prediction, lag compensation
- README rewrite matching the LibreUIUX template (mascot + brass badges + Karpathy framing + "where this fits" table)
- QUICK_START with 30-minute Godot 2D space-shooter walkthrough
- CONTRIBUTING with plugin-authoring conventions and substance bar
- CHANGELOG with per-plugin maturity matrix
- TROUBLESHOOTING covering common game-dev debug scenarios
- setup.sh installer with `--only` for selective install
- 3-tier learning paths (curated reading orders through the docs/)

### Per-plugin maturity matrix

| Plugin | v0.1 state | v0.2 state |
|---|---|---|
| ai-game-behavior | templated | shell-improved |
| animation-systems | templated | shell-improved |
| asset-pipelines | templated | shell-improved |
| audio-systems | templated | shell-improved |
| game-architecture | templated | shell-improved |
| **godot-development** | templated | **depth-complete** |
| input-systems | templated | shell-improved |
| level-design | templated | shell-improved |
| localization | templated | shell-improved |
| monetization-ethics | templated | shell-improved |
| **multiplayer-networking** | templated | **depth-complete** |
| performance-optimization | templated | shell-improved |
| physics-simulation | templated | shell-improved |
| playtesting | templated | shell-improved |
| procedural-generation | templated | shell-improved |
| save-systems | templated | shell-improved |
| shader-programming | templated | shell-improved |
| ui-game-design | templated | shell-improved |
| **unity-development** | templated | **depth-complete** |
| unreal-engine | templated | shell-improved |

### Planned for v0.3

- Promote 4-5 more plugins to depth-complete (priorities: `shader-programming`, `unreal-engine`, `ai-game-behavior`, `physics-simulation`, `performance-optimization`)
- Per-engine project scaffolds in `templates/`
- Case studies (`docs/13-case-studies/`) — currently 1 file; aim for 5-8 shipped-game post-mortems with permission

## [0.1.0] — 2026-03-01

Initial release. 20 plugin shells with templated content. Established the directory structure and naming.
