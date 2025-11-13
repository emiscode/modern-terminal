#!/bin/bash
# install-niche.sh - Install niche/experimental tools
# Idempotent: safe to run multiple times

set -e

echo "🧪 Installing niche/experimental tools..."

# Terminal emulators (via Homebrew Cask)
echo "🖥️  Installing terminal emulators..."
read -p "Install terminal emulators (WezTerm, Alacritty, Ghostty)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # WezTerm
    if ! brew list --cask wezterm &> /dev/null; then
        brew install --cask wezterm
    else
        echo "✅ WezTerm already installed"
    fi
    
    # Alacritty
    if ! brew list --cask alacritty &> /dev/null; then
        brew install --cask alacritty
    else
        echo "✅ Alacritty already installed"
    fi
    
    # Ghostty
    if ! brew list --cask ghostty &> /dev/null; then
        brew install --cask ghostty
    else
        echo "✅ Ghostty already installed"
    fi
fi

# Additional tools
echo "🔧 Installing additional tools..."

# Skim (alternative to fzf)
if ! command -v sk &> /dev/null; then
    read -p "Install skim (fzf alternative)? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        brew install skim
    fi
fi

# GitUI (alternative to lazygit)
if ! command -v gitui &> /dev/null; then
    read -p "Install gitui (lazygit alternative)? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        brew install gitui
    fi
fi

# Git extras
if ! command -v git-extras &> /dev/null; then
    read -p "Install git-extras? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        brew install git-extras
    fi
fi

echo "✅ Niche tools installation complete!"

