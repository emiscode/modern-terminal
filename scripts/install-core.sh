#!/bin/bash
# install-core.sh - Core dependencies and Homebrew setup
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

echo "🔧 Installing core dependencies..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew already installed"
fi

# Update Homebrew
echo "🔄 Updating Homebrew..."
brew update || echo "⚠️  Homebrew update failed, continuing..."

# Install essential build tools
echo "🔨 Installing build tools..."
safe_brew_install git
safe_brew_install curl
safe_brew_install wget

# Install Nerd Fonts (required for icons)
echo "🎨 Installing Nerd Fonts..."
safe_brew_install font-jetbrains-mono-nerd-font true
safe_brew_install font-fira-code-nerd-font true
safe_brew_install font-iosevka-nerd-font true

# Install dotfiles manager (chezmoi - universal, git-based)
safe_brew_install chezmoi

echo "✅ Core installation complete!"

