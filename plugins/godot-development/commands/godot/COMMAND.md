# /godot

A quick-access command for godot-development workflows in Claude Code.

## Trigger

`/godot [action] [options]`

## Input

### Actions
- `analyze` - Analyze existing godot-development implementation
- `generate` - Generate new godot-development artifacts
- `improve` - Suggest improvements to current implementation
- `validate` - Check implementation against best practices
- `document` - Generate documentation for godot-development artifacts

### Options
- `--context <path>` - Specify the file or directory to operate on
- `--format <type>` - Output format (markdown, json, yaml)
- `--verbose` - Include detailed explanations
- `--dry-run` - Preview changes without applying them

## Process

### Step 1: Context Gathering
- Read relevant files and configuration
- Identify the current state of godot-development artifacts
- Determine applicable standards and conventions

### Step 2: Analysis
- Evaluate against godot-patterns patterns
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
## Godot Development - [Action] Complete

### Changes Made
- [List of changes]

### Validation
- [Checks passed]

### Next Steps
- [Recommended follow-up actions]
```

### Error
```
## Godot Development - [Action] Failed

### Issue
[Description of the problem]

### Suggested Fix
[How to resolve the issue]
```

## Examples

```bash
# Analyze current implementation
/godot analyze

# Generate new artifacts
/godot generate --context ./src

# Validate against best practices
/godot validate --verbose

# Generate documentation
/godot document --format markdown
```
