#!/bin/bash
# install-shells.sh - Install shells and shell frameworks
# Idempotent: safe to run multiple times

set -e

echo "🐚 Installing shells..."

# zsh (usually pre-installed on macOS, but ensure it's latest)
if ! command -v zsh &> /dev/null; then
    brew install zsh
else
    echo "✅ zsh already installed"
fi

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
if ! command -v antidote &> /dev/null; then
    echo "📦 Installing Antidote..."
    brew install antidote
else
    echo "✅ Antidote already installed"
fi

# Fish shell
if ! command -v fish &> /dev/null; then
    echo "🐟 Installing Fish shell..."
    brew install fish
    # Add fish to /etc/shells
    echo $(which fish) | sudo tee -a /etc/shells
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
    if ! command -v nu &> /dev/null; then
        brew install nushell
    fi
    
    # Elvish
    if ! command -v elvish &> /dev/null; then
        brew install elvish
    fi
    
    # Xonsh (Python-based)
    if ! command -v xonsh &> /dev/null; then
        brew install xonsh
    fi
fi

echo "✅ Shell installation complete!"

