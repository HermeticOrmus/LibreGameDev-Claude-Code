# /unity

A quick-access command for unity-development workflows in Claude Code.

## Trigger

`/unity [action] [options]`

## Input

### Actions
- `analyze` - Analyze existing unity-development implementation
- `generate` - Generate new unity-development artifacts
- `improve` - Suggest improvements to current implementation
- `validate` - Check implementation against best practices
- `document` - Generate documentation for unity-development artifacts

### Options
- `--context <path>` - Specify the file or directory to operate on
- `--format <type>` - Output format (markdown, json, yaml)
- `--verbose` - Include detailed explanations
- `--dry-run` - Preview changes without applying them

## Process

### Step 1: Context Gathering
- Read relevant files and configuration
- Identify the current state of unity-development artifacts
- Determine applicable standards and conventions

### Step 2: Analysis
- Evaluate against unity-patterns patterns
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
## Unity Development - [Action] Complete

### Changes Made
- [List of changes]

### Validation
- [Checks passed]

### Next Steps
- [Recommended follow-up actions]
```

### Error
```
## Unity Development - [Action] Failed

### Issue
[Description of the problem]

### Suggested Fix
[How to resolve the issue]
```

## Examples

```bash
# Analyze current implementation
/unity analyze

# Generate new artifacts
/unity generate --context ./src

# Validate against best practices
/unity validate --verbose

# Generate documentation
/unity document --format markdown
```
