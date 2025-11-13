#!/bin/bash

###############################################################################
# COMBINATION 1: THE HYPER-MODERN STACK
###############################################################################
# Shell: nushell
# Terminal: Ghostty
# Multiplexer: zellij
# File Manager: yazi
# Editor: Helix
# Fuzzy: fzf
# History: atuin
# Git: gitui
# Theme: Catppuccin
###############################################################################

set -e

echo "=================================================="
echo "Installing Combination 1: The Hyper-Modern Stack"
echo "=================================================="

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo ""
echo "Step 1: Installing core tools..."
echo "=================================="

# Install Nushell
brew install nushell

# Install Ghostty (note: may need to be installed from source or releases)
echo "Note: Ghostty installation varies. Check https://github.com/ghostty-org/ghostty"
echo "For now, we'll note this needs manual installation"

# Install Zellij
brew install zellij

# Install Yazi
brew install yazi ffmpegthumbnailer unar jq poppler fd ripgrep fzf zoxide imagemagick

# Install Helix
brew install helix

# Install fzf
brew install fzf
$(brew --prefix)/opt/fzf/install --all

# Install Atuin
brew install atuin

# Install gitui
brew install gitui

# Install modern CLI tools
brew install eza bat ripgrep fd zoxide dust duf procs bottom sd
brew install delta glow tldr

echo ""
echo "Step 2: Installing additional dependencies..."
echo "=============================================="

# Install font (Nerd Font for icons)
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

echo ""
echo "Step 3: Setting up configurations..."
echo "====================================="

# Create config directories
mkdir -p ~/.config/nushell
mkdir -p ~/.config/zellij
mkdir -p ~/.config/yazi
mkdir -p ~/.config/helix
mkdir -p ~/.config/atuin

# Nushell config
cat > ~/.config/nushell/config.nu << 'EOF'
# Nushell Configuration
$env.config = {
    show_banner: false
    edit_mode: vi
    shell_integration: true
    
    ls: {
        use_ls_colors: true
        clickable_links: true
    }
    
    rm: {
        always_trash: true
    }
    
    table: {
        mode: rounded
        index_mode: always
        show_empty: true
    }
    
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"
    }
    
    filesize: {
        metric: false
        format: "auto"
    }
}

# Aliases
alias ls = eza --icons
alias ll = eza -l --icons --git
alias la = eza -la --icons --git
alias lt = eza --tree --icons
alias cat = bat
alias find = fd
alias grep = rg
alias cd = z

# Starship prompt
use ~/.cache/starship/init.nu
EOF

# Nushell env
cat > ~/.config/nushell/env.nu << 'EOF'
# Environment Configuration
$env.EDITOR = "helix"
$env.VISUAL = "helix"

# Zoxide
zoxide init nushell | save -f ~/.cache/zoxide/init.nu

# Starship
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

# Atuin
mkdir ~/.cache/atuin
atuin init nu | save -f ~/.cache/atuin/init.nu
EOF

# Install Starship
brew install starship

# Starship config (Catppuccin theme)
cat > ~/.config/starship.toml << 'EOF'
format = """
[╭─](bold green)$username\
$hostname\
$directory\
$git_branch\
$git_status\
$rust\
$golang\
$python\
$nodejs\
$cmd_duration
[╰─](bold green)$character"""

[character]
success_symbol = "[❯](bold green)"
error_symbol = "[❯](bold red)"

[directory]
style = "bold cyan"
truncation_length = 3
truncate_to_repo = true

[git_branch]
symbol = " "
style = "bold purple"

[git_status]
style = "bold yellow"

[cmd_duration]
min_time = 500
format = "took [$duration](bold yellow)"

# Catppuccin Mocha colors
palette = "catppuccin_mocha"

[palettes.catppuccin_mocha]
rosewater = "#f5e0dc"
flamingo = "#f2cdcd"
pink = "#f5c2e7"
mauve = "#cba6f7"
red = "#f38ba8"
maroon = "#eba0ac"
peach = "#fab387"
yellow = "#f9e2af"
green = "#a6e3a1"
teal = "#94e2d5"
sky = "#89dceb"
sapphire = "#74c7ec"
blue = "#89b4fa"
lavender = "#b4befe"
EOF

# Zellij config
cat > ~/.config/zellij/config.kdl << 'EOF'
// Zellij Configuration
theme "catppuccin-mocha"

themes {
    catppuccin-mocha {
        fg "#cdd6f4"
        bg "#1e1e2e"
        black "#45475a"
        red "#f38ba8"
        green "#a6e3a1"
        yellow "#f9e2af"
        blue "#89b4fa"
        magenta "#f5c2e7"
        cyan "#94e2d5"
        white "#bac2de"
        orange "#fab387"
    }
}

default_layout "compact"
pane_frames false
simplified_ui true
default_shell "nu"

keybinds {
    normal {
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl p" { SwitchToMode "pane"; }
        bind "Ctrl t" { SwitchToMode "tab"; }
        bind "Ctrl s" { SwitchToMode "scroll"; }
    }
}
EOF

# Yazi config
cat > ~/.config/yazi/yazi.toml << 'EOF'
# Yazi Configuration
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
cache_dir = ""

[opener]
edit = [
    { run = 'helix "$@"', block = true },
]
EOF

cat > ~/.config/yazi/theme.toml << 'EOF'
# Catppuccin Mocha theme for Yazi
[flavor]
dark = "mocha"

[manager]
cwd = { fg = "#89b4fa" }

folder = { fg = "#89b4fa" }
hovered = { reversed = true }
preview_hovered = { reversed = true }

find_keyword = { fg = "#f9e2af", bold = true, italic = true, underline = true }
find_position = { fg = "#f5c2e7", bg = "reset", bold = true, italic = true }

marker_copied = { fg = "#a6e3a1", bg = "#a6e3a1" }
marker_cut = { fg = "#f38ba8", bg = "#f38ba8" }
marker_marked = { fg = "#f9e2af", bg = "#f9e2af" }
marker_selected = { fg = "#89b4fa", bg = "#89b4fa" }

tab_active = { reversed = true }
tab_inactive = {}
tab_width = 1

count_copied = { fg = "#1e1e2e", bg = "#a6e3a1" }
count_cut = { fg = "#1e1e2e", bg = "#f38ba8" }
count_selected = { fg = "#1e1e2e", bg = "#89b4fa" }

border_symbol = "│"
border_style = { fg = "#7f849c" }
EOF

# Helix config
cat > ~/.config/helix/config.toml << 'EOF'
theme = "catppuccin_mocha"

[editor]
line-number = "relative"
mouse = true
cursorline = true
auto-save = true
idle-timeout = 0
completion-trigger-len = 1
auto-format = true
bufferline = "multiple"

[editor.cursor-shape]
insert = "bar"
normal = "block"
select = "underline"

[editor.file-picker]
hidden = false

[editor.lsp]
display-messages = true
display-inlay-hints = true

[editor.statusline]
left = ["mode", "spinner", "file-name", "file-modification-indicator"]
center = []
right = ["diagnostics", "selections", "position", "file-encoding", "file-line-ending", "file-type"]

[editor.indent-guides]
render = true
character = "│"

[keys.normal]
C-s = ":w"
C-q = ":q"
EOF

# Atuin config
cat > ~/.config/atuin/config.toml << 'EOF'
# Atuin Configuration
auto_sync = true
sync_frequency = "5m"
sync_address = "https://api.atuin.sh"
search_mode = "fuzzy"
filter_mode = "global"
style = "compact"
show_preview = true
max_preview_height = 4
update_check = true
inline_height = 20
invert = false
EOF

# Git config for delta
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.light false
git config --global delta.side-by-side true
git config --global merge.conflictstyle diff3
git config --global diff.colorMoved default

echo ""
echo "Step 4: Final setup..."
echo "======================"

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
echo "1. Install Ghostty manually from: https://github.com/ghostty-org/ghostty"
echo "2. Set Nushell as your default shell: chsh -s /opt/homebrew/bin/nu"
echo "3. Restart your terminal"
echo "4. Register for Atuin sync: atuin register (optional)"
echo ""
echo "Quick commands to try:"
echo "  - Launch yazi: yazi"
echo "  - Launch helix: hx <file>"
echo "  - Launch gitui: gitui"
echo "  - Launch zellij: zellij"
echo "  - Search history: Ctrl+R (in nushell)"
echo "  - Fuzzy find files: fzf"
echo ""
echo "Catppuccin theme has been applied to all tools!"
echo "=================================================="
