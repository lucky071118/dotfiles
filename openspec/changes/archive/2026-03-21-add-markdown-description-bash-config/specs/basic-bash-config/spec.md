## ADDED Requirements

### Requirement: Provide a basic bash configuration
A minimal .bashrc (or equivalent) file SHALL be included in the repository, containing only essential bash settings (such as prompt, history, and a few helpful aliases) suitable for all Codespaces.

#### Scenario: Basic bash config present
- **WHEN** a Codespace is initialized with this repository
- **THEN** a basic bash configuration file is present and loaded

### Requirement: Reference install.sh initial process in spec
The specification SHALL reference the initial process defined in the current install.sh file, ensuring maintainers and users understand the setup flow.

The initial process in install.sh includes:
- Applying .gitconfig and .editorconfig if present
- Installing OpenSpec CLI if Node.js and npm are available and meet version requirements
- Syncing Copilot customizations (skills/prompts) into the workspace if enabled

#### Scenario: Spec mentions install.sh process
- **WHEN** a user reads the spec
- **THEN** they see a reference to the initial process in install.sh
