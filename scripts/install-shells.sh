#!/bin/bash
# install-shells.sh - Install shells and shell frameworks
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

echo "🐚 Installing shells..."

# zsh (usually pre-installed on macOS, but ensure it's latest)
safe_brew_install zsh

# Install zsh plugin managers and frameworks
echo "🔌 Installing zsh frameworks..."

# Oh My Zsh (classic, widely used)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh My Zsh already installed"
fi

# Antidote (lightweight, fast zsh plugin manager)
safe_brew_install antidote

# Fish shell
if ! command -v fish &> /dev/null; then
    echo "🐟 Installing Fish shell..."
    safe_brew_install fish
    # Add fish to /etc/shells (only if not already there)
    if ! grep -q "$(which fish)" /etc/shells 2>/dev/null; then
        echo $(which fish) | sudo tee -a /etc/shells || echo "⚠️  Could not add fish to /etc/shells, continuing..."
    fi
else
    echo "✅ Fish already installed"
fi

# Oh My Fish (Fish framework)
if [ ! -d "$HOME/.local/share/omf" ]; then
    echo "🐟 Installing Oh My Fish..."
    curl -L https://get.oh-my.fish | fish
else
    echo "✅ Oh My Fish already installed"
fi

# Fisher (Fish plugin manager)
if ! fish -c "fisher --version" &> /dev/null; then
    echo "🎣 Installing Fisher..."
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
else
    echo "✅ Fisher already installed"
fi

# Experimental shells (optional)
read -p "Install experimental shells (nushell, elvish, xonsh)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🧪 Installing experimental shells..."
    
    # Nushell
    safe_brew_install nushell
    
    # Elvish
    safe_brew_install elvish
    
    # Xonsh (Python-based)
    safe_brew_install xonsh
fi

echo "✅ Shell installation complete!"

