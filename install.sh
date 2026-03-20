#!/usr/bin/env bash
# install.sh - GitHub Codespaces dotfiles installer
# This script is automatically run by GitHub Codespaces when the dotfiles
# repository is cloned into the environment.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing dotfiles from ${DOTFILES_DIR}"

# List of dotfiles to symlink into the home directory
DOTFILES=(
  .bashrc
  .gitconfig
  .gitignore_global
  .vimrc
  .profile
)

for file in "${DOTFILES[@]}"; do
  src="${DOTFILES_DIR}/${file}"
  dest="${HOME}/${file}"

  if [ ! -f "${src}" ]; then
    echo "    Skipping ${file} (not found in dotfiles repo)"
    continue
  fi

  # Back up existing file if it is not already a symlink to our dotfiles
  if [ -f "${dest}" ] && [ ! -L "${dest}" ]; then
    backup="${dest}.bak"
    echo "    Backing up ${dest} -> ${backup}"
    mv "${dest}" "${backup}"
  fi

  ln -sf "${src}" "${dest}"
  echo "    Linked ${src} -> ${dest}"
done

# Install Vim plugins if vim-plug is available and .vimrc is present
if command -v vim &>/dev/null && [ -f "${HOME}/.vimrc" ]; then
  if [ ! -f "${HOME}/.vim/autoload/plug.vim" ]; then
    echo "==> Installing vim-plug"
    curl -fLo "${HOME}/.vim/autoload/plug.vim" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
  echo "==> Installing Vim plugins (headless)"
  vim -es +PlugInstall +qall 2>/dev/null || true
fi

echo "==> Dotfiles installation complete!"
