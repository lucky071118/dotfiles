## Context

Currently, Copilot skills are synced to a workspace-specific directory ($TARGET_WORKSPACE/.github/skills) via install.sh. This results in each project managing its own set of skills, often through git, leading to duplication and inconsistent updates. Centralizing skills in ~/.copilot/skills will allow users to manage their skills in one place, reducing redundancy and improving maintainability.

## Goals / Non-Goals

**Goals:**
- Sync Copilot skills and prompts to ~/.copilot/skills and ~/.copilot/prompts
- Eliminate the need for per-project git management of skills
- Ensure compatibility with existing Copilot CLI workflows

**Non-Goals:**
- Changing the format or content of skills/prompts
- Managing skills for other users on the same system

## Decisions

- Use ~/.copilot/skills and ~/.copilot/prompts as the new sync targets
- Update install.sh to copy from .github/skills and .github/prompts to these locations
- Use rsync or cp as fallback, maintaining existing logic for compatibility
- Do not remove skills from the old workspace location automatically (to avoid accidental data loss)

## Risks / Trade-offs

- [Risk] Users may have legacy skills in project directories → [Mitigation] Document the new location and encourage migration
- [Risk] Potential for confusion if both locations exist → [Mitigation] Prefer ~/.copilot/skills in documentation and scripts
- [Trade-off] Centralization improves maintainability but may not suit users who want project-specific overrides
