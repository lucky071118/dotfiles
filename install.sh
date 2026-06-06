#!/usr/bin/env bash

# VS Code extensions and editor preferences are managed by Settings Sync.
# This script applies dotfile configurations that are not covered by Settings Sync.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_WORKSPACE="${GITHUB_WORKSPACE:-$PWD}"
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


# Copy Copilot skills/prompts into the active workspace for every new Codespace.
sync_copilot_customizations

echo "Dotfiles applied."
