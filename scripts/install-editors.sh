#!/bin/bash
# install-editors.sh - Install terminal code editors
# Idempotent: safe to run multiple times

set -e

echo "📝 Installing terminal editors..."

# Neovim
if ! command -v nvim &> /dev/null; then
    echo "🟢 Installing Neovim..."
    brew install neovim
else
    echo "✅ Neovim already installed"
fi

# Helix
if ! command -v hx &> /dev/null; then
    echo "🌀 Installing Helix..."
    brew install helix
else
    echo "✅ Helix already installed"
fi

# Optional editors
read -p "Install optional editors (micro, kakoune)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Micro
    if ! command -v micro &> /dev/null; then
        echo "📄 Installing Micro..."
        brew install micro
    fi
    
    # Kakoune
    if ! command -v kak &> /dev/null; then
        echo "🔪 Installing Kakoune..."
        brew install kakoune
    fi
fi

echo "✅ Editor installation complete!"

