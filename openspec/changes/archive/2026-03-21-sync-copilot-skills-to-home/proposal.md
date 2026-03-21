## Why

Currently, each project manages its own Copilot skills using git, leading to duplicated management and maintenance overhead. By centralizing skills in ~/.copilot/skills, users can manage their skills in one place, reducing redundancy and improving the overall experience.

## What Changes

- Change the sync target for Copilot skills from $TARGET_WORKSPACE/.github/skills to ~/.copilot/skills
- Update all relevant paths and logic in install.sh
- If prompts are present, also sync them to ~/.copilot/prompts

## Capabilities

### New Capabilities
- `sync-copilot-skills-to-home`: Sync Copilot skills and prompts to ~/.copilot/skills and ~/.copilot/prompts for centralized, user-level management and to avoid per-project duplication

### Modified Capabilities


## Impact

- install.sh script logic
- User environment: Copilot skills and prompts will be available in ~/.copilot/skills and ~/.copilot/prompts
- Reduces the need for per-project skills management, improving consistency
