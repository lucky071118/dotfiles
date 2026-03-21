#!/usr/bin/env bash

# VS Code extensions and editor preferences are managed by Settings Sync.
# This script applies dotfile configurations that are not covered by Settings Sync.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_WORKSPACE="${GITHUB_WORKSPACE:-$PWD}"
OPENSPEC_PACKAGE="@fission-ai/openspec"
OPENSPEC_VERSION="${OPENSPEC_VERSION:-latest}"
OPENSPEC_MIN_NODE_VERSION="20.19.0"
SYNC_COPILOT_CUSTOMIZATIONS="${SYNC_COPILOT_CUSTOMIZATIONS:-1}"

version_gte() {
  local lhs="$1"
  local rhs="$2"
  local first

  first="$(printf '%s\n%s\n' "$lhs" "$rhs" | sort -V | head -n1)"
  [[ "$first" == "$rhs" ]]
}

install_openspec() {
  local node_version
  local install_target
  local installed_version="not installed"

  if ! command -v node >/dev/null 2>&1; then
    echo "Skipped OpenSpec CLI: node is not available"
    return 0
  fi

  if ! command -v npm >/dev/null 2>&1; then
    echo "Skipped OpenSpec CLI: npm is not available"
    return 0
  fi

  node_version="$(node --version | sed 's/^v//')"
  if ! version_gte "$node_version" "$OPENSPEC_MIN_NODE_VERSION"; then
    echo "Skipped OpenSpec CLI: Node.js $node_version is below required $OPENSPEC_MIN_NODE_VERSION"
    return 0
  fi

  if command -v openspec >/dev/null 2>&1; then
    installed_version="$(openspec --version 2>/dev/null || echo "unknown")"
  fi

  install_target="${OPENSPEC_PACKAGE}@${OPENSPEC_VERSION}"
  echo "Installing OpenSpec CLI from $install_target"

  if npm install -g "$install_target"; then
    installed_version="$(openspec --version 2>/dev/null || echo "unknown")"
    echo "Installed OpenSpec CLI ($installed_version)"
  else
    echo "Skipped OpenSpec CLI: npm install failed for $install_target"
    echo "Previous OpenSpec version: $installed_version"
  fi
}

sync_copilot_customizations() {
  local source_root
  local target_root

  if [[ "$SYNC_COPILOT_CUSTOMIZATIONS" != "1" ]]; then
    echo "Skipped Copilot customizations sync: SYNC_COPILOT_CUSTOMIZATIONS=$SYNC_COPILOT_CUSTOMIZATIONS"
    return 0
  fi

  source_root="$REPO_DIR/.github"
  target_root="$HOME/.copilot"

  if [[ ! -d "$source_root/skills" && ! -d "$source_root/prompts" ]]; then
    echo "Skipped Copilot customizations sync: no source skills/prompts found"
    return 0
  fi

  mkdir -p "$target_root"

  if command -v rsync >/dev/null 2>&1; then
    if [[ -d "$source_root/skills" ]]; then
      mkdir -p "$target_root/skills"
      rsync -a --ignore-existing "$source_root/skills/" "$target_root/skills/"
      echo "Synced .github/skills to $target_root/skills (no overwrite, centralized to ~/.copilot/skills)"
    fi

    if [[ -d "$source_root/prompts" ]]; then
      mkdir -p "$target_root/prompts"
      rsync -a --ignore-existing "$source_root/prompts/" "$target_root/prompts/"
      echo "Synced .github/prompts to $target_root/prompts (no overwrite, centralized to ~/.copilot/prompts)"
    fi
  else
    if [[ -d "$source_root/skills" ]]; then
      mkdir -p "$target_root/skills"
      cp -rn "$source_root/skills/." "$target_root/skills/"
      echo "Synced .github/skills to $target_root/skills (no overwrite, centralized to ~/.copilot/skills, cp fallback)"
    fi

    if [[ -d "$source_root/prompts" ]]; then
      mkdir -p "$target_root/prompts"
      cp -rn "$source_root/prompts/." "$target_root/prompts/"
      echo "Synced .github/prompts to $target_root/prompts (no overwrite, centralized to ~/.copilot/prompts, cp fallback)"
    fi
  fi
}

# Apply git config
if [[ -f "$REPO_DIR/.gitconfig" ]]; then
  cp "$REPO_DIR/.gitconfig" "$HOME/.gitconfig"
  echo "Applied .gitconfig"
fi

# Apply editorconfig
if [[ -f "$REPO_DIR/.editorconfig" ]]; then
  cp "$REPO_DIR/.editorconfig" "$HOME/.editorconfig"
  echo "Applied .editorconfig"
fi

# Install OpenSpec CLI from the official npm package when the environment supports it.
install_openspec

# Copy Copilot skills/prompts into the active workspace for every new Codespace.
sync_copilot_customizations

echo "Dotfiles applied."
