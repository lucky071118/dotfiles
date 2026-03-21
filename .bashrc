# .bashrc (minimal for Codespaces)

# Set a simple prompt
PS1='\u@\h:\w$ '

# History settings
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:erasedups

# Basic aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Ensure ~/.local/bin is in PATH
export PATH="$HOME/.local/bin:$PATH"
