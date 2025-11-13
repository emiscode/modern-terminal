#!/bin/bash
# install-niche.sh - Install niche/experimental tools
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

echo "🧪 Installing niche/experimental tools..."

# Terminal emulators (via Homebrew Cask)
echo "🖥️  Installing terminal emulators..."
read -p "Install terminal emulators (WezTerm, Alacritty, Ghostty)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # WezTerm
    safe_brew_install wezterm true
    
    # Alacritty
    safe_brew_install alacritty true
    
    # Ghostty
    safe_brew_install ghostty true
fi

# Additional tools
echo "🔧 Installing additional tools..."

# Skim (alternative to fzf)
if ! command -v sk &> /dev/null; then
    read -p "Install skim (fzf alternative)? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        safe_brew_install skim
    fi
fi

# GitUI (alternative to lazygit)
if ! command -v gitui &> /dev/null; then
    read -p "Install gitui (lazygit alternative)? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        safe_brew_install gitui
    fi
fi

# Git extras
if ! command -v git-extras &> /dev/null; then
    read -p "Install git-extras? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        safe_brew_install git-extras
    fi
fi

echo "✅ Niche tools installation complete!"

