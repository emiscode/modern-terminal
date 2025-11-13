#!/bin/bash
# install-core.sh - Core dependencies and Homebrew setup
# Idempotent: safe to run multiple times

set -e

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
brew update

# Install essential build tools
echo "🔨 Installing build tools..."
brew install git curl wget

# Install Nerd Fonts (required for icons)
echo "🎨 Installing Nerd Fonts..."
brew install --cask font-jetbrains-mono-nerd-font \
    font-fira-code-nerd-font \
    font-iosevka-nerd-font || echo "⚠️  Some fonts may need manual installation from https://www.nerdfonts.com/"

# Install dotfiles manager (chezmoi - universal, git-based)
if ! command -v chezmoi &> /dev/null; then
    echo "📁 Installing chezmoi (dotfiles manager)..."
    brew install chezmoi
else
    echo "✅ chezmoi already installed"
fi

echo "✅ Core installation complete!"

