# /game-audio

A quick-access command for audio-systems workflows in Claude Code.

## Trigger

`/game-audio [action] [options]`

## Input

### Actions
- `analyze` - Analyze existing audio-systems implementation
- `generate` - Generate new audio-systems artifacts
- `improve` - Suggest improvements to current implementation
- `validate` - Check implementation against best practices
- `document` - Generate documentation for audio-systems artifacts

### Options
- `--context <path>` - Specify the file or directory to operate on
- `--format <type>` - Output format (markdown, json, yaml)
- `--verbose` - Include detailed explanations
- `--dry-run` - Preview changes without applying them

## Process

### Step 1: Context Gathering
- Read relevant files and configuration
- Identify the current state of audio-systems artifacts
- Determine applicable standards and conventions

### Step 2: Analysis
- Evaluate against audio-patterns patterns
- Identify gaps, issues, and opportunities
- Prioritize findings by impact and effort

### Step 3: Execution
- Apply the requested action
- Generate or modify artifacts as needed
- Validate changes against requirements

### Step 4: Output
- Present results in the requested format
- Include actionable next steps
- Flag any items requiring human decision

## Output

### Success
```
## Audio Systems - [Action] Complete

### Changes Made
- [List of changes]

### Validation
- [Checks passed]

### Next Steps
- [Recommended follow-up actions]
```

### Error
```
## Audio Systems - [Action] Failed

### Issue
[Description of the problem]

### Suggested Fix
[How to resolve the issue]
```

## Examples

```bash
# Analyze current implementation
/game-audio analyze

# Generate new artifacts
/game-audio generate --context ./src

# Validate against best practices
/game-audio validate --verbose

# Generate documentation
/game-audio document --format markdown
```
