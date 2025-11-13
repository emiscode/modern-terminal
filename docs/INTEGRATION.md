# Tool Integration Guide

This document explains how different tools integrate with each other.

## Shell Integrations

### fzf Integration

**zsh**:
- History search: `Ctrl-R` (replaced by atuin if installed)
- File search: `Ctrl-T`
- Directory search: `Alt-C`
- Custom functions: `ff` (fzf-file), `fdir` (fzf-dir)

**fish**:
- Install fzf key bindings: `$(brew --prefix)/opt/fzf/install`
- Use `fzf` command directly

### zoxide Integration

**zsh**:
```zsh
eval "$(zoxide init zsh)"
```

**fish**:
```fish
zoxide init fish | source
```

**Usage**:
- `z <directory>` - Jump to directory
- `zi` - Interactive mode
- `zoxide query -l` - List recent directories

### atuin Integration

**zsh**:
```zsh
eval "$(atuin init zsh)"
```

**fish**:
```fish
atuin init fish | source
```

**Features**:
- Replaces default `Ctrl-R` history search
- Syncs history across machines (optional)
- Fuzzy search through history
- Import existing history: `atuin import auto`

### thefuck Integration

**zsh**:
```zsh
eval $(thefuck --alias)
```

**fish**:
```fish
thefuck --alias | source
```

**Usage**: Type `fuck` after a failed command to get suggestions.

## Editor Integrations

### Neovim with LSP

1. Install Mason (LSP installer):
   - Opens automatically on first Neovim launch
   - Install language servers via `:Mason`

2. Configure LSP servers in `~/.config/nvim/lua/plugins/init.lua`

3. Key bindings:
   - `gd` - Go to definition
   - `K` - Hover documentation
   - `gr` - Find references
   - `Space rn` - Rename symbol
   - `Space ca` - Code actions

### Helix with LSP

1. LSP is built-in, no setup needed
2. Auto-detects LSP servers in PATH
3. Key bindings:
   - `Space k` - Hover
   - `Space g` - Go to definition
   - `Space a` - Code actions

## Multiplexer Integrations

### tmux with LazyGit

1. Start tmux session
2. Open LazyGit: `lg` or `lazygit`
3. Use `Ctrl-a` prefix to manage panes
4. LazyGit works in tmux panes

### zellij with Editors

1. Start zellij: `zellij`
2. Press `Ctrl-g` to enter normal mode
3. Create panes: `n` (new), `s` (split)
4. Open editor: `hx` or `nvim`
5. Switch panes: `h/j/k/l`

## File Explorer Integrations

### nnn with Editor

1. Configure editor in `~/.config/nnn/nnnrc`:
   ```
   export EDITOR="nvim"
   ```

2. Open file: Press `Enter` on file
3. Preview: Use `p` plugin

### yazi with Editor

1. Configure in `~/.config/yazi/yazi.toml`:
   ```toml
   [opener]
   edit = [
     { run = 'nvim "$@"', desc = "Edit in Neovim" },
   ]
   ```

2. Open file: Press `Enter` or `e`

### ranger with Editor

1. Configure in `~/.config/ranger/rc.conf`:
   ```
   set editor nvim
   ```

2. Open file: Press `Enter` or `l`

## Theme Consistency

All tools use **Catppuccin Mocha** theme by default:

- **Terminal**: WezTerm, Alacritty, Ghostty configs
- **Neovim**: `catppuccin/nvim` plugin
- **Helix**: `theme = "catppuccin_mocha"`
- **tmux**: Catppuccin theme via TPM
- **zellij**: Catppuccin colors in config
- **Starship**: Custom colors matching theme
- **bat**: `BAT_THEME="Catppuccin-mocha"`

### Changing Themes

1. **Gruvbox**: Change theme references to "gruvbox"
2. **Nord**: Change theme references to "nord"
3. **Tokyo Night**: Change theme references to "tokyo-night"
4. **Dracula**: Change theme references to "dracula"

## Git Integration

### LazyGit

- Launch: `lg` or `lazygit`
- Works in tmux/zellij panes
- Full git TUI with staging, commits, branches

### Delta (Git Diff)

Configure in `~/.gitconfig`:
```ini
[core]
    pager = delta

[delta]
    syntax-theme = Catppuccin-mocha
    side-by-side = true
```

### GitHub CLI (gh)

- Authenticate: `gh auth login`
- Use: `gh repo clone`, `gh issue list`, etc.

## Environment Managers

### asdf

1. Install plugins:
   ```bash
   asdf plugin add nodejs
   asdf plugin add python
   asdf plugin add golang
   asdf plugin add rust
   ```

2. Install versions:
   ```bash
   asdf install nodejs latest
   asdf install python latest
   ```

3. Set global versions:
   ```bash
   asdf global nodejs latest
   asdf global python latest
   ```

## Quick Reference

### Common Integrations

- **fzf + shell**: `Ctrl-R` for history, `Ctrl-T` for files
- **zoxide + shell**: `z <dir>` for smart navigation
- **atuin + shell**: `Ctrl-R` for enhanced history
- **LazyGit + tmux**: Run `lg` in tmux pane
- **Neovim + LSP**: Auto-completion and diagnostics
- **Helix + LSP**: Built-in, no setup needed
- **yazi + editor**: Configure opener in yazi.toml

### Troubleshooting

1. **fzf not working**: Run `$(brew --prefix)/opt/fzf/install`
2. **zoxide not working**: Check shell init file
3. **atuin not working**: Run `atuin init <shell>`
4. **LSP not working**: Install via Mason in Neovim
5. **Theme not matching**: Check all config files use same theme name

