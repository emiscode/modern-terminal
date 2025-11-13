#!/bin/bash

###############################################################################
# COMBINATION 3: THE BEGINNER-FRIENDLY STACK
###############################################################################
# Shell: fish
# Terminal: WezTerm
# Multiplexer: zellij
# File Manager: yazi
# Editor: Micro
# Fuzzy: fzf
# History: atuin
# Git: lazygit
# Theme: Gruvbox
###############################################################################

set -e

echo "=================================================="
echo "Installing Combination 3: The Beginner-Friendly Stack"
echo "=================================================="

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo ""
echo "Step 1: Installing core tools..."
echo "=================================="

# Install Fish shell
brew install fish

# Install WezTerm
brew install --cask wezterm

# Ensure WezTerm CLI is accessible
# WezTerm CLI is inside the app bundle, so we need to make it available in PATH
LOCAL_BIN="$HOME/.local/bin"
WEZTERM_CLI=""

# Try to find WezTerm app in common locations
if [ -f "/Applications/WezTerm.app/Contents/MacOS/wezterm" ]; then
    WEZTERM_CLI="/Applications/WezTerm.app/Contents/MacOS/wezterm"
else
    # Check Caskroom - use brew --prefix to find the correct path
    BREW_PREFIX=$(brew --prefix 2>/dev/null || echo "/opt/homebrew")
    CASKROOM="$BREW_PREFIX/Caskroom/wezterm"
    if [ -d "$CASKROOM" ]; then
        # Look for actual app bundle (not symlinks) in version directories
        for version_dir in "$CASKROOM"/*/; do
            if [ -d "$version_dir" ]; then
                # Look for directories containing WezTerm.app, excluding symlinks
                for subdir in "$version_dir"*; do
                    if [ -d "$subdir" ] && [ ! -L "$subdir" ]; then
                        WEZTERM_APP="$subdir/WezTerm.app"
                        if [ -d "$WEZTERM_APP" ] && [ ! -L "$WEZTERM_APP" ] && [ -f "$WEZTERM_APP/Contents/MacOS/wezterm" ]; then
                            WEZTERM_CLI="$WEZTERM_APP/Contents/MacOS/wezterm"
                            # Link the app to /Applications if not already there
                            if [ ! -e "/Applications/WezTerm.app" ]; then
                                echo "Linking WezTerm to /Applications..."
                                ln -sf "$WEZTERM_APP" /Applications/WezTerm.app
                            fi
                            break 2
                        fi
                    fi
                done
            fi
        done
    fi
fi

if [ -n "$WEZTERM_CLI" ] && [ -f "$WEZTERM_CLI" ]; then
    mkdir -p "$LOCAL_BIN"
    # Create or update symlink
    if [ -L "$LOCAL_BIN/wezterm" ]; then
        # Remove existing symlink if it's broken or points to wrong location
        if [ ! -e "$LOCAL_BIN/wezterm" ] || [ "$(readlink "$LOCAL_BIN/wezterm")" != "$WEZTERM_CLI" ]; then
            rm -f "$LOCAL_BIN/wezterm"
            ln -sf "$WEZTERM_CLI" "$LOCAL_BIN/wezterm"
            echo "✅ Updated symlink for wezterm CLI"
        else
            echo "✅ WezTerm CLI symlink already exists"
        fi
    elif [ ! -f "$LOCAL_BIN/wezterm" ]; then
        ln -sf "$WEZTERM_CLI" "$LOCAL_BIN/wezterm"
        echo "✅ Created symlink for wezterm CLI"
    fi
    # Verify wezterm command works
    if "$LOCAL_BIN/wezterm" --version &>/dev/null; then
        echo "✅ WezTerm CLI is working"
    else
        echo "⚠️  WezTerm installed but CLI verification failed"
    fi
else
    echo "⚠️  WezTerm app not found. Attempting to reinstall..."
    brew reinstall --cask wezterm 2>/dev/null
    # Try again after reinstall
    if [ -f "/Applications/WezTerm.app/Contents/MacOS/wezterm" ]; then
        WEZTERM_CLI="/Applications/WezTerm.app/Contents/MacOS/wezterm"
        mkdir -p "$LOCAL_BIN"
        ln -sf "$WEZTERM_CLI" "$LOCAL_BIN/wezterm"
        echo "✅ WezTerm reinstalled and CLI symlink created"
    else
        echo "⚠️  WezTerm installation may be incomplete. You may need to:"
        echo "   1. Manually install WezTerm from https://wezfurlong.org/wezterm/"
        echo "   2. Or run: brew reinstall --cask wezterm"
    fi
fi

# Install Zellij
brew install zellij

# Install Yazi
brew install yazi ffmpegthumbnailer unar jq poppler fd ripgrep fzf zoxide imagemagick

# Install Micro editor
brew install micro

# Install fzf
brew install fzf
$(brew --prefix)/opt/fzf/install --all

# Install Atuin
brew install atuin

# Install lazygit
brew install lazygit

# Install modern CLI tools
brew install eza bat ripgrep fd zoxide dust duf procs bottom sd
brew install delta glow tldr

echo ""
echo "Step 2: Installing additional dependencies..."
echo "=============================================="

# Install font (fonts are now available directly from Homebrew, no tap needed)
# Remove existing FiraCode Nerd Font files if they exist to avoid conflicts
if ls ~/Library/Fonts/FiraCodeNerdFont-*.ttf 2>/dev/null | grep -q .; then
    echo "Removing existing FiraCode Nerd Font files..."
    rm -f ~/Library/Fonts/FiraCodeNerdFont-*.ttf
fi
brew install --cask font-fira-code-nerd-font

# Install Fisher (Fish plugin manager)
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

echo ""
echo "Step 3: Setting up configurations..."
echo "====================================="

# Create config directories
mkdir -p ~/.config/fish
mkdir -p ~/.config/wezterm
mkdir -p ~/.config/zellij
mkdir -p ~/.config/yazi
mkdir -p ~/.config/micro
mkdir -p ~/.config/atuin

# Fish configuration
cat > ~/.config/fish/config.fish << 'EOF'
# Fish Shell Configuration - Beginner Friendly

# Remove greeting
set -g fish_greeting

# Environment variables
set -gx EDITOR micro
set -gx VISUAL micro

# Path
fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin

# Aliases - Easy to understand
alias ls="eza --icons"
alias ll="eza -l --icons --git"
alias la="eza -la --icons --git"
alias tree="eza --tree --icons"
alias cat="bat"
alias find="fd"
alias grep="rg"
alias vim="micro"
alias vi="micro"
alias lg="lazygit"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"

# Helpful functions
function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

function extract
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar x $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

# Initialize tools
if type -q zoxide
    zoxide init fish | source
end

if type -q atuin
    atuin init fish | source
end

# Starship prompt
if type -q starship
    starship init fish | source
end

# FZF configuration - Gruvbox theme
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_DEFAULT_OPTS "
--color=bg+:#3c3836,bg:#282828,spinner:#fb4934,hl:#928374
--color=fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934
--color=marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934
--layout=reverse
--border
--height=50%
"

# Yazi wrapper to change directory on exit
function ya
    set tmp (mktemp -t "yazi-cwd.XXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
EOF

# Install Starship prompt
brew install starship

# Starship configuration - Gruvbox theme
cat > ~/.config/starship.toml << 'EOF'
# Starship Configuration - Gruvbox Theme

format = """
[┌─](bold #83a598)$username\
$hostname\
$directory\
$git_branch\
$git_status\
$rust\
$golang\
$python\
$nodejs\
$cmd_duration
[└─](bold #83a598)$character"""

[character]
success_symbol = "[❯](bold #b8bb26)"
error_symbol = "[❯](bold #fb4934)"

[directory]
style = "bold #83a598"
truncation_length = 3
truncate_to_repo = true

[git_branch]
symbol = " "
style = "bold #d3869b"

[git_status]
style = "bold #fabd2f"

[cmd_duration]
min_time = 500
format = "took [$duration](bold #fabd2f)"

[username]
style_user = "bold #b8bb26"
style_root = "bold #fb4934"
format = "[$user]($style) "
disabled = false

# Language specific
[rust]
symbol = " "
style = "bold #fb4934"

[python]
symbol = " "
style = "bold #fabd2f"

[nodejs]
symbol = " "
style = "bold #b8bb26"

[golang]
symbol = " "
style = "bold #83a598"
EOF

# WezTerm configuration - Gruvbox theme
cat > ~/.config/wezterm/wezterm.lua << 'EOF'
-- WezTerm Configuration - Beginner Friendly with Gruvbox Theme

local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Appearance
config.color_scheme = 'GruvboxDark'
config.font = wezterm.font('FiraCode Nerd Font', { weight = 'Regular' })
config.font_size = 14.0
config.line_height = 1.2

-- Window
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true

-- Scrollback
config.scrollback_lines = 10000

-- Shell
config.default_prog = { '/opt/homebrew/bin/fish', '-l' }

-- Cursor
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 500

-- Keybindings - Simple and intuitive
config.keys = {
  -- Tabs
  { key = 't', mods = 'CMD', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentTab { confirm = true } },
  { key = '1', mods = 'CMD', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'CMD', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'CMD', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'CMD', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'CMD', action = wezterm.action.ActivateTab(4) },
  
  -- Panes
  { key = 'd', mods = 'CMD', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'D', mods = 'CMD|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Right' },
  
  -- Other
  { key = 'n', mods = 'CMD', action = wezterm.action.SpawnWindow },
  { key = 'q', mods = 'CMD', action = wezterm.action.QuitApplication },
  { key = 'f', mods = 'CMD', action = wezterm.action.Search 'CurrentSelectionOrEmptyString' },
}

return config
EOF

# Zellij configuration - Gruvbox theme
cat > ~/.config/zellij/config.kdl << 'EOF'
// Zellij Configuration - Beginner Friendly

theme "gruvbox-dark"

themes {
    gruvbox-dark {
        fg "#ebdbb2"
        bg "#282828"
        black "#282828"
        red "#cc241d"
        green "#98971a"
        yellow "#d79921"
        blue "#458588"
        magenta "#b16286"
        cyan "#689d6a"
        white "#a89984"
        orange "#d65d0e"
    }
}

// User-friendly settings
default_layout "compact"
pane_frames true
simplified_ui false
default_shell "fish"

// Mouse support
mouse_mode true
scroll_buffer_size 10000

// Copy on select
copy_on_select true

// Simple keybindings (more intuitive)
keybinds clear-defaults=true {
    normal {
        // Basics
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl p" { SwitchToMode "pane"; }
        bind "Ctrl t" { SwitchToMode "tab"; }
        bind "Ctrl s" { SwitchToMode "scroll"; }
        bind "Ctrl o" { SwitchToMode "session"; }
        bind "Ctrl h" { SwitchToMode "move"; }
        bind "Ctrl q" { Quit; }
        
        // Quick actions
        bind "Alt n" { NewPane; }
        bind "Alt h" { MoveFocusOrTab "Left"; }
        bind "Alt l" { MoveFocusOrTab "Right"; }
        bind "Alt j" { MoveFocus "Down"; }
        bind "Alt k" { MoveFocus "Up"; }
    }
    
    pane {
        bind "Esc" { SwitchToMode "normal"; }
        bind "h" { MoveFocus "Left"; }
        bind "l" { MoveFocus "Right"; }
        bind "j" { MoveFocus "Down"; }
        bind "k" { MoveFocus "Up"; }
        bind "n" { NewPane; SwitchToMode "normal"; }
        bind "d" { NewPane "Down"; SwitchToMode "normal"; }
        bind "r" { NewPane "Right"; SwitchToMode "normal"; }
        bind "x" { CloseFocus; SwitchToMode "normal"; }
        bind "f" { ToggleFocusFullscreen; SwitchToMode "normal"; }
    }
    
    tab {
        bind "Esc" { SwitchToMode "normal"; }
        bind "n" { NewTab; SwitchToMode "normal"; }
        bind "x" { CloseTab; SwitchToMode "normal"; }
        bind "h" { GoToPreviousTab; }
        bind "l" { GoToNextTab; }
        bind "r" { SwitchToMode "RenameTab"; TabNameInput 0; }
    }
    
    scroll {
        bind "Esc" { SwitchToMode "normal"; }
        bind "e" { EditScrollback; SwitchToMode "normal"; }
        bind "j" { ScrollDown; }
        bind "k" { ScrollUp; }
        bind "d" { HalfPageScrollDown; }
        bind "u" { HalfPageScrollUp; }
    }
}
EOF

# Yazi configuration - Gruvbox theme
cat > ~/.config/yazi/yazi.toml << 'EOF'
# Yazi Configuration - Beginner Friendly

[manager]
ratio = [1, 4, 3]
sort_by = "natural"
sort_sensitive = false
sort_reverse = false
sort_dir_first = true
linemode = "size"
show_hidden = true
show_symlink = true

[preview]
tab_size = 2
max_width = 600
max_height = 900

[opener]
edit = [
    { run = 'micro "$@"', block = true },
]
open = [
    { run = 'open "$@"', desc = "Open with default app" },
]

[open]
rules = [
    { mime = "text/*", use = "edit" },
    { mime = "application/json", use = "edit" },
    { mime = "*", use = "open" },
]
EOF

cat > ~/.config/yazi/theme.toml << 'EOF'
# Gruvbox Dark theme for Yazi

[manager]
cwd = { fg = "#83a598" }

hovered = { fg = "#282828", bg = "#83a598" }
preview_hovered = { underline = true }

find_keyword = { fg = "#fabd2f", bold = true, italic = true }
find_position = { fg = "#d3869b", bg = "reset", bold = true, italic = true }

marker_copied = { fg = "#b8bb26", bg = "#b8bb26" }
marker_cut = { fg = "#fb4934", bg = "#fb4934" }
marker_selected = { fg = "#83a598", bg = "#83a598" }

tab_active = { fg = "#282828", bg = "#83a598" }
tab_inactive = { fg = "#a89984", bg = "#3c3836" }

border_symbol = "│"
border_style = { fg = "#504945" }

[status]
separator_open = ""
separator_close = ""

[filetype]
rules = [
    { mime = "image/*", fg = "#b8bb26" },
    { mime = "video/*", fg = "#83a598" },
    { mime = "audio/*", fg = "#d3869b" },
    { mime = "application/zip", fg = "#fb4934" },
    { mime = "application/x-tar", fg = "#fb4934" },
    { mime = "application/x-bzip*", fg = "#fb4934" },
    { mime = "application/x-7z-compressed", fg = "#fb4934" },
    { mime = "application/x-rar", fg = "#fb4934" },
]
EOF

# Micro editor configuration - Gruvbox theme
cat > ~/.config/micro/settings.json << 'EOF'
{
    "autoclose": true,
    "autoindent": true,
    "autosave": 2,
    "colorscheme": "gruvbox-tc",
    "cursorline": true,
    "diffgutter": true,
    "filetype": "unknown",
    "ignorecase": true,
    "keepautoindent": true,
    "matchbrace": true,
    "mkparents": true,
    "mouse": true,
    "rmtrailingws": true,
    "ruler": true,
    "savecursor": true,
    "saveundo": true,
    "scrollbar": true,
    "scrollmargin": 3,
    "scrollspeed": 2,
    "smartpaste": true,
    "softwrap": false,
    "splitbottom": true,
    "splitright": true,
    "statusline": true,
    "syntax": true,
    "tabsize": 4,
    "tabstospaces": true
}
EOF

# Micro keybindings (make them more user-friendly)
cat > ~/.config/micro/bindings.json << 'EOF'
{
    "CtrlS": "Save",
    "CtrlQ": "Quit",
    "CtrlW": "Close",
    "CtrlZ": "Undo",
    "CtrlY": "Redo",
    "CtrlF": "Find",
    "CtrlH": "FindNext",
    "CtrlR": "Replace",
    "CtrlA": "SelectAll",
    "CtrlC": "Copy",
    "CtrlX": "Cut",
    "CtrlV": "Paste",
    "CtrlD": "DuplicateLine",
    "CtrlK": "CutLine",
    "CtrlT": "AddTab",
    "CtrlN": "SpawnMultiCursor"
}
EOF

# Atuin configuration
cat > ~/.config/atuin/config.toml << 'EOF'
# Atuin Configuration - Beginner Friendly

auto_sync = true
sync_frequency = "5m"
search_mode = "fuzzy"
filter_mode = "global"
style = "auto"
show_preview = true
max_preview_height = 4
update_check = true
inline_height = 20
invert = false

# Easy to understand history settings
history_filter = []
search_mode_shell_up_key_binding = "fuzzy"
EOF

# Git config for delta - Gruvbox theme
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.light false
git config --global delta.side-by-side false
git config --global delta.line-numbers true
git config --global merge.conflictstyle diff3
git config --global diff.colorMoved default

# Delta Gruvbox theme
git config --global delta.syntax-theme "gruvbox-dark"

echo ""
echo "Step 4: Setting up Fish shell..."
echo "================================="

# Install useful Fish plugins
fish -c "fisher install PatrickF1/fzf.fish" 2>/dev/null || true
fish -c "fisher install jorgebucaran/autopair.fish" 2>/dev/null || true
fish -c "fisher install gazorby/fish-abbreviation-tips" 2>/dev/null || true

echo ""
echo "Step 5: Final setup..."
echo "======================"

# Add Fish to shells if not already there
if ! grep -q "/opt/homebrew/bin/fish" /etc/shells; then
    echo "Adding Fish to /etc/shells..."
    echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
fi

# Initialize atuin
if ! atuin account login 2>/dev/null; then
    echo "Note: Run 'atuin register' or 'atuin login' to sync history across machines"
fi

echo ""
echo "=================================================="
echo "Installation Complete!"
echo "=================================================="
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.config/fish/config.fish"
echo "2. Verify WezTerm CLI: wezterm --version"
echo "3. Launch WezTerm (from Applications or run: wezterm)"
echo "4. Set Fish as default shell: chsh -s /opt/homebrew/bin/fish"
echo "5. Register for Atuin sync: atuin register (optional)"
echo ""
echo "Quick start guide:"
echo "  - Press Ctrl+R to search history (Atuin)"
echo "  - Press Ctrl+T to fuzzy find files"
echo "  - Type 'ya' to launch Yazi file manager"
echo "  - Type 'micro <file>' to edit files"
echo "  - Type 'lg' to launch lazygit"
echo "  - Press Ctrl+P in Zellij for pane mode"
echo "  - Press Ctrl+T in Zellij for tab mode"
echo ""
echo "Fish shell tips:"
echo "  - Fish has autosuggestions (gray text) - press → to accept"
echo "  - Fish has syntax highlighting built-in"
echo "  - Type a command and press Tab for completions"
echo "  - Use 'll' for detailed file listing"
echo "  - Use 'tree' to see directory structure"
echo ""
echo "Gruvbox theme has been applied to all tools!"
echo "=================================================="
