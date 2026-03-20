# ~/.zshrc - Zsh interactive shell configuration

# ── History ───────────────────────────────────────────────────────────────────
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=10000
SAVEHIST=20000
setopt HIST_IGNORE_DUPS     # do not record consecutive duplicate commands
setopt HIST_IGNORE_SPACE    # do not record commands starting with a space
setopt SHARE_HISTORY        # share history between all sessions
setopt APPEND_HISTORY

# ── Shell options ─────────────────────────────────────────────────────────────
setopt AUTO_CD              # type a directory name to cd into it
setopt CORRECT              # auto-correct minor typos
setopt GLOB_DOTS            # include dotfiles in glob patterns
setopt EXTENDED_GLOB

# ── Completion ───────────────────────────────────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive

# ── Key bindings ─────────────────────────────────────────────────────────────
bindkey -e                        # emacs key bindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ── Prompt ────────────────────────────────────────────────────────────────────
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST

PROMPT='%F{green}%n@%m%f:%F{blue}%~%f%F{yellow}${vcs_info_msg_0_}%f%# '

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
alias lt='ls -lhtr'

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
alias reload='source ~/.zshrc'
alias path='echo ${PATH} | tr ":" "\n"'

# ── Functions ────────────────────────────────────────────────────────────────
mkcd() {
  mkdir -p "$1" && cd "$1"
}

ginfo() {
  echo "Branch : $(git branch --show-current 2>/dev/null)"
  echo "Remote : $(git remote -v 2>/dev/null | head -1)"
  echo "Status :"
  git status -s 2>/dev/null
}
