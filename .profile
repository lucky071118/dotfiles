# ~/.profile - Login shell configuration
# Sourced by login shells (bash, sh, dash).
# Keep this file portable – no bash-isms.

# ── Path additions ────────────────────────────────────────────────────────────
export PATH="${HOME}/.local/bin:${HOME}/bin:${PATH}"

# ── Environment ───────────────────────────────────────────────────────────────
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LANG=en_US.UTF-8

# ── Source .bashrc for interactive bash login shells ──────────────────────────
if [ -n "${BASH_VERSION}" ] && [ -f "${HOME}/.bashrc" ]; then
  # shellcheck source=/dev/null
  . "${HOME}/.bashrc"
fi
