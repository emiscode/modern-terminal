# Fish shell configuration
# Main config file

# Path configuration
fish_add_path /opt/homebrew/bin /opt/homebrew/sbin
fish_add_path ~/.local/bin

# Initialize Starship prompt
if command -v starship &> /dev/null
    starship init fish | source
end

# Tool integrations
if command -v zoxide &> /dev/null
    zoxide init fish | source
end

if command -v atuin &> /dev/null
    atuin init fish | source
end

# Aliases
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias hx="helix"
alias cat="bat"
alias ls="eza"
alias ll="eza -l"
alias la="eza -la"
alias grep="rg"
alias find="fd"
alias top="htop"
alias lg="lazygit"

# Git aliases
alias g="git"
alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias gd="git diff"
alias gl="git log"
alias gp="git push"
alias gs="git status"

# Docker aliases
alias d="docker"
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcd="docker-compose down"

# File explorers
alias n="nnn"
alias y="yazi"
alias r="ranger"

# Quick config edits
alias zshconfig="nvim ~/.zshrc"
alias fishconfig="nvim ~/.config/fish/config.fish"
alias nvimconfig="nvim ~/.config/nvim/init.lua"
alias tmuxconfig="nvim ~/.config/tmux/tmux.conf"

# Reload fish config
alias reload="source ~/.config/fish/config.fish"

# Set bat theme
set -gx BAT_THEME "Catppuccin-mocha"

