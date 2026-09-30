# Changelog

## [1.0.0] - 2026-09-30

This release makes the pack installable. Until now `setup.sh` copied plugin folders into `~/.claude/plugins/`, which Claude Code does not load plugins from, and the files sat in nested `AGENT.md` / `COMMAND.md` folders that Claude Code does not read either. After this release every agent, command, and skill loads through Claude Code's plugin system.

These plugins also ship in [claude-code-game-development](https://github.com/HermeticOrmus/claude-code-game-development) v2.0.0, which is where they keep growing. This pack stays installable as it is.

### Added

- `.claude-plugin/marketplace.json`: the repo is now the `libre-gamedev` plugin marketplace. Install with `/plugin marketplace add HermeticOrmus/LibreGameDev-Claude-Code` and `/plugin install <plugin>@libre-gamedev`.
- A `plugin.json` manifest for each of the 20 plugins, with a description and keywords.
- `libre-gamedev-hooks`, an optional plugin that wires the hook scripts into Claude Code: one line of context at session start for Godot, Unity, Unreal, and web game projects; a confirmation prompt before a tool touches `.env` files, keys, Android keystores, Godot export credentials, or credentials files, and before `rm -rf`, force pushes, hard resets, or `git clean -f`; a note after a write leaves a file empty, and a once-per-session reminder to run the tests after a code change.
- Argument hints on every command, listing its actions (for example `/godot [scene|script|extend|test] <feature>`).
- `setup.sh --list`, `--scope`, and `--uninstall`.
- A CI workflow that validates the marketplace and every plugin, installs all of them into a clean config, and fails if any plugin reports load errors.
- A feedback issue form (`.github/ISSUE_TEMPLATE/feedback.yml`).

### Changed

- `setup.sh` now installs through `claude plugin install` instead of copying folders. `--only` works as before; `--plugins-dir` is accepted but no longer used. It needs the `claude` CLI and `jq`.
- Files moved to the layout Claude Code loads: `agents/<name>.md`, `commands/<name>.md`, `skills/<name>/SKILL.md`. Content moved with them unchanged.
- `godot-development`, `unity-development`, and `multiplayer-networking` each carried two agents, two commands, and two skills (the v0.2 depth-complete files and the older v0.1 files). Each now has one of each: the v0.2 file stays primary and every section of the older file is merged into it (typed GDScript and GUT patterns, ScriptableObject event channels, Godot netcode code, and the per-action command reference).
- Every agent, command, and skill description is rewritten to say when to use it, so Claude picks the right one. Agents use `model: inherit` (the Godot, Unity, and network agents were pinned to `sonnet`), so they follow the model you run.
- The hook scripts moved from `hooks/` into `plugins/libre-gamedev-hooks/hooks/` and now read the JSON Claude Code sends on stdin. They no longer write log files.
- README: install instructions for Claude Code, a terminal, and a checkout; plugin tables that list each plugin's real agent, command, and skill; counts that match the manifests; a Feedback section.

### Fixed

- Command names in the README, QUICK_START, TROUBLESHOOTING, and learning paths now match the real commands: `/animate`, `/game-audio`, `/game-perf`, `/save-system`, `/input-system`, and `/level-design` (the docs said `/animation`, `/audio`, `/perf-game`, `/save`, `/input`, and `/level`, which do not exist).
- Links to the reference manual pointed at a `docs/` folder that is not in this repo. They now point at the manual in claude-code-game-development.
- TROUBLESHOOTING's install check now uses `claude plugin list` instead of listing `~/.claude/plugins/`.

### For existing users

If you ran the old `setup.sh`, you have `~/.claude/plugins/libre-gamedev-*` folders that Claude Code never loaded. You can delete them, then run `./setup.sh` (or the `/plugin` commands above).

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
