## ADDED Requirements

### Requirement: Centralized Copilot skills directory
The system SHALL sync Copilot skills from .github/skills in the repository to the user's ~/.copilot/skills directory, ensuring all skills are managed centrally and persist across projects.

#### Scenario: Skills present in .github/skills
- **WHEN** the install.sh script is run and .github/skills exists in the repository
- **THEN** all files and subdirectories from .github/skills SHALL be copied to ~/.copilot/skills, preserving structure and not overwriting existing files

#### Scenario: No skills present in .github/skills
- **WHEN** the install.sh script is run and .github/skills does not exist
- **THEN** no action SHALL be taken for skills sync

### Requirement: Centralized Copilot prompts directory
The system SHALL sync Copilot prompts from .github/prompts in the repository to the user's ~/.copilot/prompts directory, ensuring all prompts are managed centrally and persist across projects.

#### Scenario: Prompts present in .github/prompts
- **WHEN** the install.sh script is run and .github/prompts exists in the repository
- **THEN** all files and subdirectories from .github/prompts SHALL be copied to ~/.copilot/prompts, preserving structure and not overwriting existing files

#### Scenario: No prompts present in .github/prompts
- **WHEN** the install.sh script is run and .github/prompts does not exist
- **THEN** no action SHALL be taken for prompts sync
