# Tool integrations
# fzf, zoxide, atuin, etc.

# fzf - Fuzzy finder
if command -v fzf &> /dev/null; then
    # Setup fzf key bindings and fuzzy completion
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    
    # Custom fzf functions
    if [ -f "${HOME}/.config/zsh/functions.zsh" ]; then
        # Functions file may contain fzf-based functions
        :
    fi
fi

# zoxide - Smart cd replacement
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# atuin - Shell history
if command -v atuin &> /dev/null; then
    eval "$(atuin init zsh)"
    
    # Disable default zsh history search (atuin handles it)
    bindkey -r '^R'
    bindkey '^R' _atuin_search_widget
fi

# thefuck - Command correction
if command -v fuck &> /dev/null; then
    eval $(thefuck --alias)
fi

# bat - Better cat
if command -v bat &> /dev/null; then
    alias cat='bat'
    export BAT_THEME="Catppuccin-mocha"  # Can be changed to Gruvbox, Nord, etc.
fi

# eza - Better ls
if command -v eza &> /dev/null; then
    alias ls='eza'
    alias ll='eza -l'
    alias la='eza -la'
    alias lt='eza --tree'
fi

# ripgrep - Better grep
if command -v rg &> /dev/null; then
    alias grep='rg'
fi

# fd - Better find
if command -v fd &> /dev/null; then
    alias find='fd'
fi

