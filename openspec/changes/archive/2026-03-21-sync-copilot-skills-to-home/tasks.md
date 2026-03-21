## 1. Preparation

- [x] 1.1 Update install.sh to use ~/.copilot/skills and ~/.copilot/prompts as sync targets
- [x] 1.2 Ensure fallback logic (rsync/cp) works with new paths

## 2. Implementation

- [x] 2.1 Test syncing skills from .github/skills to ~/.copilot/skills
- [x] 2.2 Test syncing prompts from .github/prompts to ~/.copilot/prompts
- [x] 2.3 Verify no files are overwritten if they already exist in ~/.copilot/skills or ~/.copilot/prompts

## 3. Documentation

- [x] 3.1 Update any relevant documentation to reference the new centralized skills/prompts location
