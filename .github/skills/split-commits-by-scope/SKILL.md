---
name: split-commits-by-scope
description: Splits staged git changes into multiple commits, each grouped by logical scope (such as directory, file type, or feature), to make code review easier and more focused.
---

## How It Works
1. Analyze all staged changes (`git diff --cached --name-only`).
2. Group files by scope (directory, file type, or custom markers).
3. For each group:
   - Unstage all changes (`git reset`)
   - Stage only the files in the group (`git add <files>`)
   - Commit with a descriptive message (`git commit -m "<scope>: <description>"`)
4. Repeat for all groups until all changes are committed.

## Usage Example
```bash
git add .
/skills/split-commits-by-scope
# Follow prompts or review auto-generated commits
```

## Implementation Notes
- Scopes can be determined by directory, file type, or custom code markers.
- Commit messages should clearly describe the scope and changes.
- Useful for large or mixed changes to keep commits atomic and reviews simple.

## Customization
- You can adjust grouping logic to fit your team's workflow (e.g., by feature, ticket, or code marker).
- Optionally, prompt the user to confirm or edit each commit message before committing.
