# ~/.bashrc - Bash interactive shell configuration

# ── Guard: only run for interactive shells ────────────────────────────────────
[[ $- != *i* ]] && return

# ── History ───────────────────────────────────────────────────────────────────
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth   # ignore duplicate lines and lines starting with space
shopt -s histappend      # append to history file rather than overwriting

# ── Shell options ─────────────────────────────────────────────────────────────
shopt -s checkwinsize    # update LINES and COLUMNS after each command
shopt -s globstar        # enable ** glob patterns
shopt -s cdspell         # auto-correct minor typos in cd

# ── Prompt ────────────────────────────────────────────────────────────────────
# Shows: user@host:directory (git branch) $
_git_branch() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  echo " (${branch})"
}

PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[33m\]$(_git_branch)\[\e[0m\]\$ '

# ── Environment ───────────────────────────────────────────────────────────────
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LESS='-R --quit-if-one-screen'
export LANG=en_US.UTF-8

# ── Path additions ────────────────────────────────────────────────────────────
export PATH="${HOME}/.local/bin:${HOME}/bin:${PATH}"

# ── Aliases – Navigation ──────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# ── Aliases – Listing ────────────────────────────────────────────────────────
alias ls='ls --color=auto'
alias ll='ls -lhF'
alias la='ls -lhAF'
alias lt='ls -lhtr'    # sort by modification time, oldest first

# ── Aliases – Git ────────────────────────────────────────────────────────────
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate --all'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch --all --prune'

# ── Aliases – Misc ───────────────────────────────────────────────────────────
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias cls='clear'
alias reload='source ~/.bashrc'
alias path='echo ${PATH} | tr ":" "\n"'

# ── Functions ────────────────────────────────────────────────────────────────
# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Show a short summary of the current git repo
ginfo() {
  echo "Branch : $(git branch --show-current 2>/dev/null)"
  echo "Remote : $(git remote -v 2>/dev/null | head -1)"
  echo "Status :"
  git status -s 2>/dev/null
}

# ── Enable bash completion ────────────────────────────────────────────────────
if [ -f /usr/share/bash-completion/bash_completion ]; then
  # shellcheck source=/dev/null
  source /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  # shellcheck source=/dev/null
  source /etc/bash_completion
fi
