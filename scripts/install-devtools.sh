#!/bin/bash
# install-devtools.sh - Install development tools and utilities
# Idempotent: safe to run multiple times

set -e

echo "🛠️  Installing development tools..."

# Terminal multiplexers
echo "📺 Installing terminal multiplexers..."
if ! command -v tmux &> /dev/null; then
    brew install tmux
else
    echo "✅ tmux already installed"
fi

if ! command -v zellij &> /dev/null; then
    brew install zellij
else
    echo "✅ zellij already installed"
fi

# Prompt
echo "⭐ Installing Starship prompt..."
if ! command -v starship &> /dev/null; then
    brew install starship
else
    echo "✅ Starship already installed"
fi

# Fuzzy finder and history
echo "🔍 Installing fuzzy finders..."
if ! command -v fzf &> /dev/null; then
    brew install fzf
    # Install key bindings and fuzzy completion
    $(brew --prefix)/opt/fzf/install --all
else
    echo "✅ fzf already installed"
fi

# Atuin (shell history)
if ! command -v atuin &> /dev/null; then
    brew install atuin
else
    echo "✅ atuin already installed"
fi

# Zoxide (smart cd)
if ! command -v zoxide &> /dev/null; then
    brew install zoxide
else
    echo "✅ zoxide already installed"
fi

# TheFuck (optional)
read -p "Install thefuck (command correction)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if ! command -v fuck &> /dev/null; then
        brew install thefuck
    fi
fi

# Git tools
echo "📦 Installing Git tools..."
if ! command -v lazygit &> /dev/null; then
    brew install lazygit
else
    echo "✅ lazygit already installed"
fi

if ! command -v delta &> /dev/null; then
    brew install git-delta
else
    echo "✅ delta already installed"
fi

if ! command -v gh &> /dev/null; then
    brew install gh
else
    echo "✅ GitHub CLI already installed"
fi

# File explorers
echo "📁 Installing file explorers..."
for tool in nnn yazi lf ranger xplr; do
    if ! command -v $tool &> /dev/null; then
        brew install $tool
    else
        echo "✅ $tool already installed"
    fi
done

# Modern CLI replacements
echo "⚡ Installing modern CLI replacements..."
brew install ripgrep fd bat eza tldr jq yq htop btop dust procs bottom bandwhich

# Environment managers
echo "🌍 Installing environment managers..."
if ! command -v asdf &> /dev/null; then
    brew install asdf
else
    echo "✅ asdf already installed"
fi

echo "✅ Development tools installation complete!"

