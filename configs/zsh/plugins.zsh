# Plugin manager configuration
# Using Antidote for fast, lazy-loading plugin management

# Antidote plugin manager
if command -v antidote &> /dev/null; then
    # Initialize antidote
    source $(brew --prefix antidote)/share/antidote/antidote.zsh
    antidote load
    
    # Plugin list (create if doesn't exist)
    ANTIDOTE_PLUGINS_FILE="${ZDOTDIR:-~}/.zsh_plugins.txt"
    
    if [ ! -f "$ANTIDOTE_PLUGINS_FILE" ]; then
        cat > "$ANTIDOTE_PLUGINS_FILE" <<EOF
# zsh plugins managed by antidote
ohmyzsh/ohmyzsh path:lib
ohmyzsh/ohmyzsh path:plugins/git
ohmyzsh/ohmyzsh path:plugins/docker
ohmyzsh/ohmyzsh path:plugins/docker-compose

# Syntax highlighting (must be last)
zsh-users/zsh-syntax-highlighting

# Autosuggestions
zsh-users/zsh-autosuggestions
EOF
    fi
    
    antidote bundle < "$ANTIDOTE_PLUGINS_FILE" > "${ZDOTDIR:-~}/.zsh_plugins.zsh"
    source "${ZDOTDIR:-~}/.zsh_plugins.zsh"
else
    # Fallback to Oh My Zsh if antidote not available
    export ZSH="$HOME/.oh-my-zsh"
    
    # Oh My Zsh plugins
    plugins=(
        git
        docker
        docker-compose
        colored-man-pages
        command-not-found
    )
    
    # Load Oh My Zsh
    if [ -f "$ZSH/oh-my-zsh.sh" ]; then
        source "$ZSH/oh-my-zsh.sh"
    fi
    
    # zsh-syntax-highlighting
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        source "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    fi
    
    # zsh-autosuggestions
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        source "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    fi
fi

