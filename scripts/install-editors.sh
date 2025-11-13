#!/bin/bash
# install-editors.sh - Install terminal code editors
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

echo "📝 Installing terminal editors..."

# Neovim
echo "🟢 Installing Neovim..."
safe_brew_install neovim

# Helix
echo "🌀 Installing Helix..."
safe_brew_install helix

# Optional editors
read -p "Install optional editors (micro, kakoune)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Micro
    echo "📄 Installing Micro..."
    safe_brew_install micro
    
    # Kakoune
    echo "🔪 Installing Kakoune..."
    safe_brew_install kakoune
fi

echo "✅ Editor installation complete!"

