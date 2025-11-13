# 📖 Quick Reference Card

## Essential Commands for All Combinations

---

## 🔧 Common Modern CLI Tools

| Old Command | New Tool | Usage |
|-------------|----------|-------|
| `ls` | `eza` | `ls`, `ll`, `la`, `lt` |
| `cat` | `bat` | `cat file.txt` |
| `find` | `fd` | `fd pattern` |
| `grep` | `ripgrep` | `rg pattern` |
| `cd` | `zoxide` | `z partial-name` |
| `du` | `dust` | `dust` |
| `df` | `duf` | `duf` |
| `ps` | `procs` | `procs` |
| `top` | `bottom/btop` | `btm` or `btop` |

---

## 🎯 Combination 1: Hyper-Modern

### Nushell Basics
```bash
# Structured data
ls | where size > 1mb
ps | where cpu > 10
ls | select name size | sort-by size

# System info
sys
version
help commands

# Configuration
config nu  # Opens config file
```

### Helix Editor
```bash
hx file.txt                # Open file

# In editor:
Space + f                  # File picker
Space + s                  # Symbol picker
/                          # Search
n / N                      # Next/previous match
v / V / Ctrl+v            # Select mode
C                          # Multiple cursors
gd                         # Go to definition
Space + w                  # Save
Space + q                  # Quit
```

### Zellij Multiplexer
```bash
zellij                     # Start
Ctrl + p                   # Pane mode
Ctrl + t                   # Tab mode
Ctrl + o                   # Session mode
Ctrl + s                   # Scroll mode
Ctrl + q                   # Quit

# In pane mode:
n                          # New pane
d                          # Pane down
r                          # Pane right
x                          # Close pane
```

### Yazi File Manager
```bash
yazi                       # Start
ya                         # Start (cd on exit)

# In yazi:
j/k or ↑/↓                # Navigate
h/l or ←/→                # Parent/child directory
Enter                      # Open
Space                      # Select
v                          # Visual mode
y                          # Copy
x                          # Cut
p                          # Paste
d                          # Delete
a                          # Create file/directory
/                          # Search
i                          # Image preview
```

### Gitui
```bash
gitui                      # Start

# In gitui:
1-5                        # Switch tabs
c                          # Commit
P                          # Push
F                          # Fetch
p                          # Pull
Enter                      # Stage/unstage
d                          # Show diff
q                          # Quit
```

### Atuin History
```bash
Ctrl + r                   # Search history
atuin search <query>       # CLI search
atuin stats                # Statistics
atuin sync                 # Sync history
```

---

## ⚡ Combination 2: Performance

### Zsh + Zinit
```bash
# Built-in aliases
ll                         # Long list
la                         # All files
..                         # Up one directory
...                        # Up two directories

# History
history                    # Show history
Ctrl + r                   # Fuzzy search (McFly)
```

### Neovim
```bash
nvim file.txt              # Open file

# Essential commands:
:w                         # Save
:q                         # Quit
:wq                        # Save and quit
:q!                        # Quit without saving

# Leader key shortcuts (Space):
Space + e                  # File explorer
Space + ff                 # Find files
Space + fg                 # Live grep
Space + fb                 # Buffers

# Navigation:
Ctrl + h/j/k/l            # Window navigation
Shift + h/l               # Buffer navigation
```

### Tmux
```bash
tmux                       # Start
tmux ls                    # List sessions
tmux attach -t name        # Attach to session

# Prefix: Ctrl+a
Ctrl+a |                   # Split horizontal
Ctrl+a -                   # Split vertical
Ctrl+a h/j/k/l            # Navigate panes
Ctrl+a c                   # New window
Ctrl+a n                   # Next window
Ctrl+a d                   # Detach
Ctrl+a [                   # Copy mode
Ctrl+a r                   # Reload config
```

### lf File Manager
```bash
lf                         # Start

# In lf:
j/k or ↑/↓                # Navigate
h/l or ←/→                # Parent/child directory
Enter                      # Open
Space                      # Select
y                          # Copy
d                          # Cut (move)
p                          # Paste
x                          # Delete
a                          # New file
A                          # New directory
/                          # Search
```

### Lazygit
```bash
lazygit                    # Start
lg                         # Alias

# In lazygit:
Tab                        # Switch panels
Space                      # Stage/unstage
c                          # Commit
P                          # Push
p                          # Pull
[/]                        # Previous/next tab
Enter                      # Open/expand
?                          # Help
q                          # Quit
```

### McFly History
```bash
Ctrl + r                   # Search history
# Type to search, use arrows to navigate
```

---

## 🌟 Combination 3: Beginner-Friendly

### Fish Shell
```bash
# Auto-suggestions (gray text)
# Press → to accept

# Completions
Tab                        # Show completions
Tab Tab                    # Cycle through

# Abbreviations
abbr                       # List abbreviations
abbr -a gs git status     # Add abbreviation

# Functions
funced name                # Edit function
funcsave name              # Save function
```

### WezTerm
```bash
# Tabs
Cmd + t                    # New tab
Cmd + w                    # Close tab
Cmd + 1-5                  # Switch to tab

# Splits
Cmd + d                    # Split horizontal
Cmd + Shift + d            # Split vertical
Cmd + h/j/k/l             # Navigate panes
```

### Micro Editor
```bash
micro file.txt             # Open file

# All standard shortcuts work:
Ctrl + s                   # Save
Ctrl + q                   # Quit
Ctrl + z                   # Undo
Ctrl + y                   # Redo
Ctrl + f                   # Find
Ctrl + h                   # Find next
Ctrl + r                   # Replace
Ctrl + a                   # Select all
Ctrl + c                   # Copy
Ctrl + x                   # Cut
Ctrl + v                   # Paste
Ctrl + g                   # Go to line
Ctrl + e                   # Command palette
```

---

## 🏛️ Combination 4: Classic Modern

### Zsh + Oh My Zsh
```bash
# Git aliases (git plugin)
gst                        # git status
ga                         # git add
gc                         # git commit
gp                         # git push
gl                         # git pull
gd                         # git diff
gco                        # git checkout
glog                       # git log --graph

# General aliases
alias                      # List all aliases
take dir                   # mkdir && cd
extract file.zip           # Extract any archive
```

### iTerm2
```bash
# Tabs
Cmd + t                    # New tab
Cmd + w                    # Close tab
Cmd + number               # Switch to tab

# Splits
Cmd + d                    # Split horizontal
Cmd + Shift + d            # Split vertical
Cmd + [/]                  # Navigate splits
Cmd + Opt + arrow          # Resize pane

# Other
Cmd + f                    # Search
Cmd + Opt + b              # Instant replay
Cmd + Shift + h            # Paste history
```

### Ranger File Manager
```bash
ranger                     # Start
rcd                        # Start (cd on exit)

# In ranger:
j/k or ↑/↓                # Navigate
h/l or ←/→                # Parent/child directory
Enter                      # Open
Space                      # Select
yy                         # Copy
dd                         # Cut
pp                         # Paste
dD                         # Delete
/                          # Search
n/N                        # Next/previous match
i                          # Preview mode
S                          # Open shell
```

### Tig
```bash
tig                        # Start
tig status                 # Status view
tig log                    # Log view

# In tig:
j/k                        # Navigate
Enter                      # Open/expand
u                          # Stage/unstage
!                          # Revert
C                          # Commit
h                          # Help
q                          # Quit
```

### HSTR History
```bash
Ctrl + r                   # Start HSTR
# Type to filter
# Arrow keys to navigate
# Enter to select
```

---

## 🔍 FZF (All Combinations)

```bash
# Universal shortcuts
Ctrl + t                   # Find files
Ctrl + r                   # Search history
Alt + c                    # Change directory (zsh)

# In FZF:
↑/↓ or Ctrl+j/k          # Navigate
Enter                      # Select
Esc                        # Cancel
Tab                        # Multi-select
Shift+Tab                  # Deselect
```

---

## 🌈 Theme Customization

### Change Themes

#### Terminal Themes
```bash
# Alacritty
nano ~/.config/alacritty/alacritty.toml
# Change color scheme section

# WezTerm
nano ~/.config/wezterm/wezterm.lua
# Change color_scheme = "..."

# iTerm2
# Preferences → Profiles → Colors → Color Presets
```

#### Editor Themes
```bash
# Helix
hx ~/.config/helix/config.toml
# Change theme = "..."

# Neovim
# Edit init.lua, change colorscheme line

# Micro
micro ~/.config/micro/settings.json
# Change colorscheme value
```

---

## 🔧 Configuration Files

### Combo 1: Hyper-Modern
```
~/.config/nushell/config.nu
~/.config/nushell/env.nu
~/.config/helix/config.toml
~/.config/zellij/config.kdl
~/.config/yazi/yazi.toml
~/.config/starship.toml
~/.config/atuin/config.toml
```

### Combo 2: Performance
```
~/.zshrc
~/.config/alacritty/alacritty.toml
~/.config/nvim/init.lua
~/.config/lf/lfrc
~/.tmux.conf
```

### Combo 3: Beginner-Friendly
```
~/.config/fish/config.fish
~/.config/wezterm/wezterm.lua
~/.config/zellij/config.kdl
~/.config/yazi/yazi.toml
~/.config/micro/settings.json
~/.config/starship.toml
~/.config/atuin/config.toml
```

### Combo 4: Classic Modern
```
~/.zshrc
~/.p10k.zsh (Powerlevel10k)
~/.config/nvim/init.lua
~/.config/ranger/rc.conf
~/.tmux.conf
```

---

## 🆘 Emergency Commands

### When Things Go Wrong
```bash
# Reset shell
exec $SHELL

# Reload config
source ~/.zshrc            # zsh
source ~/.config/fish/config.fish  # fish

# Kill stuck process
killall -9 [process-name]

# Check what's using a port
lsof -i :[port]

# Disk space emergency
dust -d 1 ~                # Find large directories
duf                        # Check disk usage
```

### Restore Backup
```bash
# If you backed up configs
cp ~/terminal-backup/.zshrc ~/.zshrc
cp -r ~/terminal-backup/.config/* ~/.config/
```

---

## 📚 Getting Help

### In-App Help
```bash
# General
man [command]              # Manual page
[command] --help          # Help flag
tldr [command]            # Simplified examples

# Tool-specific
help                       # Nushell help
:help                      # Neovim help
?                          # Ranger/lazygit help
Ctrl+g                     # Helix help
```

### Online Resources
```bash
# Search
google "how to [task] in [tool]"

# Official docs
# See tool websites in README.md

# Communities
# Reddit: r/neovim, r/commandline, r/vim
# Discord: Various tool servers
```

---

## 💡 Pro Tips

### Speed Up Workflow
```bash
# Use aliases
alias c='clear'
alias v='nvim'
alias l='eza -la'

# Use zoxide
z doc                      # Jump to Documents
z down                     # Jump to Downloads

# Use fzf preview
export FZF_CTRL_T_OPTS="--preview 'bat {}'"
```

### Keyboard Shortcuts
```bash
# Universal
Ctrl + c                   # Cancel
Ctrl + d                   # Exit/EOF
Ctrl + l                   # Clear screen
Ctrl + a                   # Start of line
Ctrl + e                   # End of line
Ctrl + u                   # Clear line

# macOS Terminal
Cmd + k                    # Clear scrollback
Cmd + t                    # New tab
Cmd + w                    # Close tab
```

---

## 📋 Cheat Sheet Print Version

**File Managers:**
- **yazi/ya**: j/k=nav, Space=select, y=copy, p=paste, d=delete
- **ranger**: same + zz for settings
- **lf**: same but simpler

**Editors:**
- **Helix**: Space=leader, /=search, v=select, C=multicursor
- **Neovim**: :=command, Space=leader, i=insert, Esc=normal
- **Micro**: Ctrl+letter for everything

**Multiplexers:**
- **Zellij**: Ctrl+p=panes, Ctrl+t=tabs
- **tmux**: Prefix(Ctrl+a) then command

**Git:**
- **gitui**: 1-5=tabs, c=commit, P=push
- **lazygit**: Space=stage, c=commit, P=push
- **tig**: j/k=nav, u=stage, C=commit

---

**Keep this card handy! 📌**

Print or save for quick reference while learning your new terminal setup.
