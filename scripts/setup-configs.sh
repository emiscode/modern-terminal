#!/bin/bash
# setup-configs.sh - Symlink configs to ~/.config
# Idempotent: safe to run multiple times

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CONFIGS_DIR="$PROJECT_ROOT/configs"
TARGET_DIR="$HOME/.config"

echo "🔗 Setting up configuration files..."

# Create ~/.config if it doesn't exist
mkdir -p "$TARGET_DIR"

# Function to safely create symlink
# Set FORCE_LINK=1 to skip prompts and create backups automatically
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ -L "$target" ]; then
        if [ "$FORCE_LINK" = "1" ]; then
            rm "$target"
            ln -s "$source" "$target"
            echo "✅ Linked: $target (replaced existing symlink)"
        else
            echo "⚠️  Symlink already exists: $target"
            read -p "Replace it? [y/N] " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                rm "$target"
                ln -s "$source" "$target"
                echo "✅ Linked: $target"
            fi
        fi
    elif [ -e "$target" ]; then
        if [ "$FORCE_LINK" = "1" ]; then
            mv "$target" "${target}.backup.$(date +%Y%m%d_%H%M%S)"
            ln -s "$source" "$target"
            echo "✅ Linked: $target (backup created)"
        else
            echo "⚠️  File/directory already exists: $target"
            read -p "Backup and replace? [y/N] " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                mv "$target" "${target}.backup.$(date +%Y%m%d_%H%M%S)"
                ln -s "$source" "$target"
                echo "✅ Linked: $target (backup created)"
            fi
        fi
    else
        ln -s "$source" "$target"
        echo "✅ Linked: $target"
    fi
}

# Symlink all config directories
for dir in zsh fish tmux zellij nvim helix wezterm alacritty ghostty yazi nnn lf ranger xplr; do
    if [ -d "$CONFIGS_DIR/$dir" ]; then
        create_symlink "$CONFIGS_DIR/$dir" "$TARGET_DIR/$dir"
    fi
done

# Symlink starship.toml
if [ -f "$CONFIGS_DIR/starship.toml" ]; then
    create_symlink "$CONFIGS_DIR/starship.toml" "$TARGET_DIR/starship.toml"
fi

# Special handling for zsh: symlink to ~/.zshrc if zsh config exists
if [ -d "$CONFIGS_DIR/zsh" ] && [ -f "$CONFIGS_DIR/zsh/zshrc" ]; then
    create_symlink "$CONFIGS_DIR/zsh/zshrc" "$HOME/.zshrc"
fi

# Special handling for fish: symlink to ~/.config/fish/config.fish
if [ -d "$CONFIGS_DIR/fish" ] && [ -f "$CONFIGS_DIR/fish/config.fish" ]; then
    mkdir -p "$TARGET_DIR/fish"
    create_symlink "$CONFIGS_DIR/fish/config.fish" "$TARGET_DIR/fish/config.fish"
fi

echo ""
echo "✅ Configuration setup complete!"
echo ""
echo "Note: Some tools may need additional setup:"
echo "- Run 'atuin import auto' to import shell history"
echo "- Run 'zellij setup --generate-config' if needed"
echo "- Configure atuin sync: 'atuin register' (optional)"

