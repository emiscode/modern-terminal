#!/bin/bash
# install-devtools.sh - Install development tools and utilities
# Idempotent: safe to run multiple times

# Function to safely install brew packages (continues even if already installed)
safe_brew_install() {
    local package="$1"
    local is_cask="${2:-false}"
    local output
    
    if [ "$is_cask" = "true" ]; then
        if brew list --cask "$package" &> /dev/null; then
            echo "✅ $package already installed (cask)"
            return 0
        fi
        # Try to install and capture output
        output=$(brew install --cask "$package" 2>&1) || {
            if echo "$output" | grep -q "already an App"; then
                echo "✅ $package already installed (app exists)"
                return 0
            fi
            echo "⚠️  Failed to install $package (may already be installed), continuing..."
            return 0
        }
    else
        if command -v "$package" &> /dev/null || brew list "$package" &> /dev/null 2>&1; then
            echo "✅ $package already installed"
            return 0
        fi
        brew install "$package" || {
            echo "⚠️  Failed to install $package (may already be installed), continuing..."
            return 0
        }
    fi
}

echo "🛠️  Installing development tools..."

# Terminal multiplexers
echo "📺 Installing terminal multiplexers..."
safe_brew_install tmux
safe_brew_install zellij

# Prompt
echo "⭐ Installing Starship prompt..."
safe_brew_install starship

# Fuzzy finder and history
echo "🔍 Installing fuzzy finders..."
if ! command -v fzf &> /dev/null; then
    safe_brew_install fzf
    # Install key bindings and fuzzy completion
    $(brew --prefix)/opt/fzf/install --all || echo "⚠️  fzf key bindings installation failed, continuing..."
else
    echo "✅ fzf already installed"
fi

# Atuin (shell history)
safe_brew_install atuin

# Zoxide (smart cd)
safe_brew_install zoxide

# TheFuck (optional)
read -p "Install thefuck (command correction)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    safe_brew_install thefuck
fi

# Git tools
echo "📦 Installing Git tools..."
safe_brew_install lazygit
safe_brew_install git-delta
safe_brew_install gh

# File explorers
echo "📁 Installing file explorers..."
for tool in nnn yazi lf ranger xplr; do
    safe_brew_install "$tool"
done

# Modern CLI replacements
echo "⚡ Installing modern CLI replacements..."
for tool in ripgrep fd bat eza tldr jq yq htop btop dust procs bottom bandwhich; do
    safe_brew_install "$tool"
done

# Environment managers
echo "🌍 Installing environment managers..."
safe_brew_install asdf

echo "✅ Development tools installation complete!"

