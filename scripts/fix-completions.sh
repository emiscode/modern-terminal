#!/bin/bash
# fix-completions.sh - Fix zsh completion issues
# Handles missing completion files, broken symlinks, and regenerates completions
# Usage: ./fix-completions.sh [--auto] (--auto runs without prompts)

# Don't exit on error - we want to continue even if some operations fail
set +e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AUTO_MODE=false

# Check for --auto flag
if [[ "$1" == "--auto" ]] || [[ "$1" == "--non-interactive" ]]; then
    AUTO_MODE=true
fi

echo "🔧 Fixing zsh completion issues..."
echo ""

# Check if we're on macOS with Homebrew
if [[ "$OSTYPE" == "darwin"* ]] && command -v brew &> /dev/null; then
    BREW_PREFIX=$(brew --prefix)
    SITE_FUNCTIONS="$BREW_PREFIX/share/zsh/site-functions"
    
    if [ "$AUTO_MODE" = false ]; then
        echo "📁 Checking completion directory: $SITE_FUNCTIONS"
    fi
    
    if [ -d "$SITE_FUNCTIONS" ]; then
        # Find and remove broken symlinks
        echo "🔍 Checking for broken symlinks..."
        broken_links=$(find "$SITE_FUNCTIONS" -type l ! -exec test -e {} \; -print 2>/dev/null || true)
        
        if [ -n "$broken_links" ]; then
            if [ "$AUTO_MODE" = true ]; then
                echo "⚠️  Found broken symlinks, removing automatically..."
                echo "$broken_links" | while read -r link; do
                    rm -f "$link"
                    echo "✅ Removed: $link"
                done
            else
                echo "⚠️  Found broken symlinks:"
                echo "$broken_links"
                read -p "Remove broken symlinks? [y/N] " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    echo "$broken_links" | while read -r link; do
                        rm -f "$link"
                        echo "✅ Removed: $link"
                    done
                fi
            fi
        else
            echo "✅ No broken symlinks found"
        fi
        
        # Check for common missing completion files
        if [ "$AUTO_MODE" = false ]; then
            echo ""
            echo "🔍 Checking for missing completion files..."
        fi
        
        missing_files=()
        for file in "_wezterm" "_alacritty" "_ghostty"; do
            if [ -L "$SITE_FUNCTIONS/$file" ] && [ ! -e "$SITE_FUNCTIONS/$file" ]; then
                missing_files+=("$file")
            fi
        done
        
        if [ ${#missing_files[@]} -gt 0 ] && [ "$AUTO_MODE" = false ]; then
            echo "⚠️  Found missing completion files:"
            for file in "${missing_files[@]}"; do
                echo "  - $file"
            done
            echo ""
            echo "💡 These are usually harmless. Your zshrc should use 'compinit -u' to ignore them."
        fi
    else
        if [ "$AUTO_MODE" = false ]; then
            echo "⚠️  Completion directory not found: $SITE_FUNCTIONS"
        fi
    fi
    
    # Reinstall packages that might have missing completions
    if [ "$AUTO_MODE" = true ]; then
        echo ""
        echo "🔄 Regenerating completions for terminal emulators..."
        if brew list --cask wezterm &> /dev/null; then
            echo "🔄 Reinstalling wezterm to fix completions..."
            brew reinstall --cask wezterm 2>/dev/null || echo "⚠️  Failed to reinstall wezterm (may already be correct)"
        fi
        if brew list --cask alacritty &> /dev/null; then
            echo "🔄 Reinstalling alacritty to fix completions..."
            brew reinstall --cask alacritty 2>/dev/null || echo "⚠️  Failed to reinstall alacritty (may already be correct)"
        fi
        if brew list --cask ghostty &> /dev/null; then
            echo "🔄 Reinstalling ghostty to fix completions..."
            brew reinstall --cask ghostty 2>/dev/null || echo "⚠️  Failed to reinstall ghostty (may already be correct)"
        fi
    elif [ "$AUTO_MODE" = false ]; then
        # Original interactive code
        echo ""
        echo "🔄 Reinstall packages to regenerate completions?"
        echo "   This can fix missing completion files for:"
        echo "   - wezterm"
        echo "   - alacritty"
        echo "   - ghostty"
        read -p "Reinstall terminal emulators? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if brew list --cask wezterm &> /dev/null; then
                echo "🔄 Reinstalling wezterm..."
                brew reinstall --cask wezterm || echo "⚠️  Failed to reinstall wezterm"
            fi
            if brew list --cask alacritty &> /dev/null; then
                echo "🔄 Reinstalling alacritty..."
                brew reinstall --cask alacritty || echo "⚠️  Failed to reinstall alacritty"
            fi
            if brew list --cask ghostty &> /dev/null; then
                echo "🔄 Reinstalling ghostty..."
                brew reinstall --cask ghostty || echo "⚠️  Failed to reinstall ghostty"
            fi
        fi
    fi
else
    if [ "$AUTO_MODE" = false ]; then
        echo "⚠️  This script is designed for macOS with Homebrew"
        echo "   On other systems, check your zsh completion directories manually"
    fi
fi

# Verify zshrc uses compinit -u
if [ "$AUTO_MODE" = false ]; then
    echo ""
    echo "🔍 Checking zshrc configuration..."
fi

ZSHRC="$HOME/.zshrc"
if [ -f "$ZSHRC" ]; then
    if grep -q "compinit -u" "$ZSHRC"; then
        if [ "$AUTO_MODE" = false ]; then
            echo "✅ zshrc correctly uses 'compinit -u'"
        fi
    elif grep -q "compinit" "$ZSHRC"; then
        if [ "$AUTO_MODE" = true ]; then
            # Auto-update in non-interactive mode
            cp "$ZSHRC" "${ZSHRC}.backup.$(date +%Y%m%d_%H%M%S)"
            sed -i '' 's/^compinit$/compinit -u  # -u flag ignores missing completion files/' "$ZSHRC"
            echo "✅ Updated zshrc to use 'compinit -u'"
        else
            echo "⚠️  zshrc uses 'compinit' without -u flag"
            echo "   Consider updating to 'compinit -u' to ignore missing completion files"
            read -p "Update zshrc now? [y/N] " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                cp "$ZSHRC" "${ZSHRC}.backup.$(date +%Y%m%d_%H%M%S)"
                sed -i '' 's/^compinit$/compinit -u  # -u flag ignores missing completion files/' "$ZSHRC"
                echo "✅ Updated zshrc"
                echo "   Run 'source ~/.zshrc' to apply changes"
            fi
        fi
    fi
fi

if [ "$AUTO_MODE" = false ]; then
    echo ""
    echo "✅ Completion fix complete!"
    echo ""
    echo "💡 Tip: If you still see completion errors, make sure your zshrc uses 'compinit -u'"
    echo "   This tells zsh to ignore missing completion files gracefully"
fi

