# /save-system

A quick-access command for save-systems workflows in Claude Code.

## Trigger

`/save-system [action] [options]`

## Input

### Actions
- `analyze` - Analyze existing save-systems implementation
- `generate` - Generate new save-systems artifacts
- `improve` - Suggest improvements to current implementation
- `validate` - Check implementation against best practices
- `document` - Generate documentation for save-systems artifacts

### Options
- `--context <path>` - Specify the file or directory to operate on
- `--format <type>` - Output format (markdown, json, yaml)
- `--verbose` - Include detailed explanations
- `--dry-run` - Preview changes without applying them

## Process

### Step 1: Context Gathering
- Read relevant files and configuration
- Identify the current state of save-systems artifacts
- Determine applicable standards and conventions

### Step 2: Analysis
- Evaluate against save-system-patterns patterns
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
## Save Systems - [Action] Complete

### Changes Made
- [List of changes]

### Validation
- [Checks passed]

### Next Steps
- [Recommended follow-up actions]
```

### Error
```
## Save Systems - [Action] Failed

### Issue
[Description of the problem]

### Suggested Fix
[How to resolve the issue]
```

## Examples

```bash
# Analyze current implementation
/save-system analyze

# Generate new artifacts
/save-system generate --context ./src

# Validate against best practices
/save-system validate --verbose

# Generate documentation
/save-system document --format markdown
```
