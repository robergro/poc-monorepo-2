# Claude Skills for Spark Components

This project includes custom Claude skills to streamline component development workflows.

## Available Skills

### spark-component-dependency

**Location:** `~/.claude/skills/spark-component-dependency/`

**Purpose:** Creates a new component in the Dependencies folder from the template with proper documentation and placeholder replacement.

**Usage:**
```
/spark-component-dependency
```

or

```
Use the spark-component-dependency skill to create a new component
```

**What it does:**
1. Copies the template from `.template/component/` to `Dependencies/{ComponentName}Component/`
2. Updates `documentation.json` with component metadata (title, description, figma, zeroheight links)
3. Updates `Documentation.md` with proper links
4. Replaces all placeholders in filenames and file contents:
   - `__COMPONENT_NAME___` → PascalCase (e.g., SparkButton)
   - `___component_name___` → lowercase (e.g., sparkbutton)
5. Renames anatomy image to `{component_name_lower}-anatomy.png`

**Required Parameters:**
- Component Name (PascalCase, e.g., "SparkButton")
- Description (for documentation)
- Figma Link (URL)
- Zeroheight Link (URL)
- Anatomy Image Path (local file path)

**Example:**
```
Create a new component SparkButton with:
- Description: "A customizable button component"
- Figma: "https://figma.com/design/..."
- Zeroheight: "https://zeroheight.com/..."
- Anatomy image: "./assets/button-anatomy.png"
```

## Other Available Skills

Based on the system configuration, the following skills are also available:

- `spark-component-use-case` - Create/update use case files
- `spark-component-accessibility-identifier` - Create/update accessibility identifiers
- `spark-component-environment` - Create/update environment files
- `spark-component-enum` - Create/update enum files
- `spark-component-constants` - Create/update constants files
- `spark-component-view-model` - Create/update view model files
- `spark-component-view` - Create/update view files (UIKit & SwiftUI)
- `spark-component-model` - Create/update model files
- `spark-component-snapshots-testing` - Create/update snapshot tests
- `spark-component-documentation` - Create/update DocC documentation
- `spark-component-pull-request` - Manage branches and push
- `spark-check-before-push` - Run checks before git push
- `spark-push` - Launch git push actions
- `spark-update-demo-code-syntax` - Update code syntax in demo app

## Skill Development

Skills are stored in `~/.claude/skills/{skill-name}/` and must include:
- `SKILL.md` - The skill definition with YAML frontmatter
- Optional `template/` folder - For template files

**Frontmatter format:**
```yaml
---
name: skill-name
description: Brief description of what the skill does
---
```

## Notes

- Skills are automatically discovered by Claude Code
- Use `/skill-name` to invoke a skill in conversation
- Skills can prompt for missing parameters during execution
