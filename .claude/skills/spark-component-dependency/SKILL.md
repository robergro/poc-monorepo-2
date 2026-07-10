---
name: spark-component-dependency
description: Create a new component in the Dependencies folder from template with proper documentation and placeholders replacement.
---

# Add New Component to Dependencies Folder

## Overview & Prerequisites

This skill helps you create a new component in the Dependencies folder using the template-based approach.

❗️ This skill should be used from the root of the monorepo project ❗️

The skill will:
1. Copy the component template
2. Update documentation files with correct metadata
3. Replace all placeholders in filenames and file contents
4. Handle anatomy image setup

## Input Parameters

When executing this skill, gather the following information from the user:
- **Component Name** (e.g., Button, Avatar) - PascalCase format
- **Description** - Brief description for documentation
- **Figma Link** - URL to the Figma design
- **Zeroheight Link** - URL to the Zeroheight specifications
- **Anatomy Image Path** - Local path to the anatomy image file

If any parameter is missing, use `AskUserQuestion` to collect it.

## Workflow

### Step 1: Validate Parameters

Confirm you have all required parameters:
- [ ] Component Name (PascalCase)
- [ ] Description
- [ ] Figma Link
- [ ] Zeroheight Link
- [ ] Anatomy Image Path (verify file exists)

### Step 2: Prepare Component Names

From the component name (e.g., "Button", "Avatar"), generate:
- **COMPONENT_NAME_PASCAL**: PascalCase (e.g., "button")
- **COMPONENT_NAME_LOWER**: Lowercase (e.g., "button")
- **REMOVE SPARK MENTION**: Remove all *Spark* or *SparkComponent* in the name (e.g, "SparkButton" must be "Button" ; "SparkComponentButton" must be "Button" ; )

### Step 3: Copy Template to Dependencies

Copy the template to create the new component directory:

```bash
cp -r .template/component/ "Dependencies/SparkComponent${COMPONENT_NAME_PASCAL}/"
```

### Step 4: Handle Anatomy Image

- [ ] Copy anatomy image into the *.github/assets*.
- [ ] Rename image to `sparkcomponent-{component_name_lower}-anatomy.png`

### Step 5: Update documentation.json

Read `Dependencies/SparkComponent{ComponentName}/documentation.json` and update:
- [ ] `title`: Set to component name + "SparkComponent" in prefix (e.g., "SparkComponentButton")
- [ ] `description`: Set to the user-provided description
- [ ] `figma`: Set to the Figma link
- [ ] `zeroheight`: Set to the Zeroheight link
- [ ] `image`: Set to component name in lowercase (e.g., "sparkbutton")

### Step 6: Update Documentation.md

Read `Dependencies/SparkComponent{ComponentName}/Sources/Core/Documentation.docc/Documentation.md` and:
- [ ] Replace `TODO` in Zeroheight link with actual URL
- [ ] Replace `TODO` in Figma link with actual URL

### Step 7: Replace All Placeholders

**IMPORTANT**: Replace these exact placeholders in all files:
- `__COMPONENT_NAME___` (2 underscores prefix, 3 suffix) → PascalCase name
- `___component_name___` (3 underscores each side) → lowercase name
- `___COMPONENT_NAME___` (3 underscores each side) → PascalCase name

**Files to process:**
- [ ] `README.md`
- [ ] `documentation.json`
- [ ] `Sources/Core/Documentation.docc/Documentation.md`
- [ ] `Sources/Core/__COMPONENT_NAME___.swift`
- [ ] `Sources/Testing/__COMPONENT_NAME___ComponentTesting.swift`
- [ ] `Tests/UnitTests/__COMPONENT_NAME___Tests.swift`
- [ ] `Tests/SnapshotTests/__COMPONENT_NAME___SnapshotsTests.swift`
- [ ] `.sourcery.yml`
- [ ] Any other files containing placeholders

**Process:**
1. Update file contents first using Edit tool
2. Rename files with placeholders in names using `mv` command

### Step 8: Verify Component Structure

After all replacements:
- [ ] List files in the new component directory
- [ ] Read `documentation.json` to verify all fields are set
- [ ] Read `README.md` to confirm no placeholders remain
- [ ] Search for any remaining placeholder strings

## Placeholder Details

Pay careful attention to underscores:

| Placeholder | Underscores | Replace With | Example |
|------------|-------------|--------------|---------|
| `__COMPONENT_NAME___` | 2 prefix, 3 suffix | PascalCase | SegmentedControl |
| `___component_name___` | 3 each side | lowercase | segmentedcontrol |
| `___COMPONENT_NAME___` | 3 each side | PascalCase | SegmentedControl |

## Example Usage

**User Request:**
```
Add a new component SparkButton with:
- Description: "A customizable button component"
- Figma: "https://figma.com/design/..."
- Zeroheight: "https://zeroheight.com/..."
- Anatomy image: "./assets/button-anatomy.png"
```

**Expected Result:**
- ✅ Directory created: `Dependencies/SparkComponentButton/`
- ✅ `documentation.json` populated with correct values
- ✅ All placeholders replaced: "Button" or "button"
- ✅ Anatomy image: `sparkcomponent-button-anatomy.png`
- ✅ Documentation links updated
- ✅ Files renamed: `SparkButton.swift`, `SparkButtonTests.swift`, etc.

## Error Handling

If any step fails:
1. Stop the process immediately
2. Report the specific error to the user
3. Provide the step that failed
4. Suggest corrective action if applicable

## Completion Checklist

Before finishing:
- [ ] All placeholders replaced in file contents
- [ ] All files with placeholder names renamed correctly
- [ ] `documentation.json` has all fields filled (no "TODO")
- [ ] `Documentation.md` has all fields filled (no "TODO")
- [ ] Anatomy image renamed and in correct location
- [ ] Component directory structure matches template
- [ ] No errors reported during execution

## Final Output

When complete, provide the user with:
1. ✅ Success message
2. 📁 Path to new component: `Dependencies/SparkComponent{ComponentName}/`
3. 📝 Summary of modified files
4. ➡️ Next steps:
   - Implement component logic in `Sources/Core/{ComponentName}.swift`
   - Review and customize generated files
   - Run any required build/test commands
