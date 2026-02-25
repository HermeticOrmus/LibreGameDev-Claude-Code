# Contributing to LibreGameDev-Claude-Code

Thank you for your interest in contributing. This guide covers how to add new plugins, improve existing ones, and maintain quality across the collection.

## Philosophy

Every plugin should **empower** game developers. We build tools that teach, not tools that create dependency. If a plugin does something for the developer, it should also explain *why* and *how*.

## Adding a New Plugin

### 1. Propose

Open an issue describing:
- The game development domain the plugin covers
- Why existing plugins do not already cover it
- What agents, commands, and skills it would include

### 2. Structure

Create the following directory structure under `plugins/`:

```
plugins/your-plugin-name/
  README.md         # 50-80 lines: description, contents, usage
  agents/
    AGENT.md        # 80-150 lines: identity, expertise, behavior, output
  commands/
    COMMAND.md      # 60-100 lines: trigger, input, process, output, examples
  skills/
    SKILL.md        # 60-100 lines: knowledge, patterns, anti-patterns, refs
```

### 3. Content Guidelines

**README.md**: Clear description of what the plugin provides, what files are included, and practical usage examples with code.

**AGENT.md**: Define a specialist persona. Include identity, areas of expertise, behavioral rules (what the agent does and does not do), preferred tools and methods, and output format.

**COMMAND.md**: Specify the slash command trigger, expected input format, step-by-step process, structured output format, and at least two usage examples.

**SKILL.md**: Document the knowledge base with concrete patterns (with code), anti-patterns (with explanations of why they fail), and references to authoritative sources.

### 4. Quality Checklist

- [ ] All four files are present and within the specified line ranges
- [ ] No placeholder or TODO content
- [ ] Code examples are syntactically correct
- [ ] Anti-patterns include clear explanations
- [ ] References point to real, authoritative sources
- [ ] Plugin is added to the root README.md table

## Improving Existing Plugins

- Open a PR with a clear description of what changed and why
- Keep changes focused: one improvement per PR
- If adding new patterns or anti-patterns, include code examples
- Update the CHANGELOG.md

## Commit Messages

Follow conventional commits:

```
type(scope): description

feat(procgen): add wave function collapse patterns
fix(godot): correct signal connection syntax in examples
docs(readme): update plugin count badge
```

## Code of Conduct

All contributors must follow the [Contributor Covenant v2.1](CODE_OF_CONDUCT.md).

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
