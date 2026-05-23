# Contributing

Game dev is wide. Twenty plugins covers a lot but not everything. PRs welcome — especially genre-specific patterns, console-specific knowledge (within NDA limits), and translations of the learning paths.

## What we welcome

- **Bug fixes** in any plugin (agent, command, or skill content)
- **Engine depth** — Godot is currently most complete; Unity + Unreal can be deepened
- **Genre-specific patterns** — roguelikes, immersive sims, RTSes, fighting games, MMOs each have specialized patterns
- **Mobile-specific patterns** — touch controls, battery optimization, app store review patterns
- **Console-specific patterns** — Switch, PlayStation, Xbox (within NDA limits — generic patterns only)
- **Web game patterns** — Phaser, Pixi, Three.js, plain Canvas
- **Case studies** of real shipped games with permission to discuss
- **Translations** of learning paths — game dev community is heavily ESL; non-English under-served
- **Doc improvements** — clearer worked examples, more diagrams, better cross-references

## What we don't accept

- Closed-source engines without an alternative (proprietary AAA-only patterns belong on internal docs)
- Plugins requiring paid IDEs without a free-tier alternative
- Patterns that violate platform-holder NDAs (Switch internals, etc.)
- AI-generated content with no real-game verification — game dev needs domain reality testing
- Predatory monetization patterns. Ethical monetization is welcome (see `monetization-ethics` plugin)

## Setup

```bash
git clone https://github.com/<your-username>/LibreGameDev-Claude-Code.git
cd LibreGameDev-Claude-Code
./setup.sh
```

Make changes, test against a real game project, then submit.

## Branch + PR workflow

```
git checkout -b feat/<slug>       # new plugin or major content addition
git checkout -b fix/<slug>        # bug fix
git checkout -b deepen/<plugin>   # deepening an existing thin plugin
git checkout -b docs/<slug>       # docs only
git checkout -b casestudy/<game>  # case study addition
```

Commit format: `type(scope): description` — e.g., `deepen(unity-development): add Addressables + Render Pipeline switching patterns`.

PR template:

```markdown
## Why
<motivation in 1-3 sentences>

## What changed
<bulleted list>

## How to verify
<scenario to pose to the agent + expected response shape>

## Real-game verification (if applicable)
<which engine version, which project, what game type>

## Notes
<follow-ups, related issues, depth assessment>
```

## Plugin-authoring conventions

Each plugin lives in `plugins/<name>/` with:

```
plugins/<name>/
├── README.md       # overview of what the plugin covers + when to use
├── agents/
│   └── <name>.md   # specialist agent prompt
├── commands/
│   └── <name>.md   # slash command logic
└── skills/
    └── <name>.md   # reference pattern library
```

### Agent prompts

Should include:

- Frontmatter `name:` and `description:`
- "Purpose" section
- "Core Principles" — biases this agent applies
- "Capabilities" — what it knows about, in detail
- Real-engine grounding — reference specific engines and engine versions
- Aim for 150-300 lines of substantive content

### Commands

Should include:

- A clear job-to-be-done framing
- At least one concrete code example with real engine APIs
- A worked example from problem statement to working code
- Awareness of common game-dev traps (pooling, fixed vs. variable timestep, frame budget)
- Aim for 200-400 lines

### Skills

Should include:

- A pattern library, not a tutorial
- Cross-references to the relevant `docs/` sections
- Common-mistakes section
- Engine-specific notes where they differ
- Aim for 100-200 lines

## The substance bar

LibreGameDev's flagship plugins (`unity-development`, `godot-development`, `multiplayer-networking`) match LibreUIUX substance — real engine expertise, real code examples in the engine's actual language, accurate API names. If you're adding a new plugin or deepening a shell, please contribute at that depth.

The maturity matrix in [CHANGELOG.md](CHANGELOG.md) tracks which plugins are depth-complete and which need work.

## Working with the docs/ folder

The `docs/` folder is a 13-section reference. New content welcome via PR — drop into the appropriate section's directory with a clear filename. Cross-link from the section's `README.md`.

Style:

- Markdown, code-fenced examples
- One concept per file
- 5-15 minute read length
- At least one worked example per concept

## Code of conduct

See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## License

By submitting a PR you agree your contribution is licensed under the same MIT license as the project. No CLA.
