# Modern Terminal Setup - High-Level Plan

## Overview

This setup provides a **modular, testable terminal environment** for macOS developers. You can mix and match tools to find your perfect combination.

## Core Philosophy

- **Modular**: Each tool has its own config directory
- **Testable**: Easy to switch between alternatives
- **Git-friendly**: All configs are version-controlled
- **Idempotent**: Installation scripts can be run multiple times safely

## Main Components

### 1. Shells
- **Primary**: zsh (default on macOS)
- **Alternative**: fish (modern, user-friendly)
- **Experimental**: nushell, elvish, xonsh

**How to switch**: Change your default shell with `chsh -s $(which fish)` or use `exec fish` in zsh.

### 2. Terminal Emulators
- **Recommended**: WezTerm (GPU-accelerated, cross-platform, highly configurable)
- **Alternatives**: Alacritty (minimal, fast), Ghostty (modern, minimal), iTerm2 (feature-rich)

**How to switch**: Install via Homebrew, then use the provided config files.

### 3. Terminal Multiplexers
- **Classic**: tmux (proven, widely used)
- **Modern**: zellij (tiling, modern UX)

**How to switch**: Use `tmux` or `zellij` commands. Both can coexist.

### 4. Code Editors
- **Primary**: Neovim (Lua-based, highly extensible)
- **Alternative**: Helix (modal, modern, built-in LSP)

**How to switch**: Use `nvim` or `hx` commands. Both configured with LSP support.

### 5. Key Utilities
- **Fuzzy finder**: fzf (file search, history search)
- **Smart cd**: zoxide (learns your directory patterns)
- **History**: atuin (syncs across machines, fuzzy search)
- **File search**: ripgrep (rg), fd
- **Modern replacements**: bat, eza, dust, procs

## Setup Combinations

### Setup 1: "Classic Power User"
- Shell: zsh + oh-my-zsh
- Multiplexer: tmux
- Editor: Neovim
- Prompt: Starship
- **Best for**: Traditional Unix workflow, maximum compatibility

### Setup 2: "Modern Minimalist"
- Shell: fish
- Multiplexer: zellij
- Editor: Helix
- Prompt: Starship
- **Best for**: Modern UX, less configuration needed

### Setup 3: "Experimental Mix"
- Shell: nushell
- Multiplexer: zellij
- Editor: Neovim
- Prompt: Starship
- **Best for**: Trying cutting-edge tools

### Setup 4: "Maximum Productivity"
- Shell: zsh + custom plugins
- Multiplexer: tmux (with TPM)
- Editor: Neovim (full LSP setup)
- Prompt: Starship
- File explorer: yazi
- **Best for**: Power users who want everything

## Directory Structure

```
~/.config/
├── zsh/              # zsh configuration (modular)
├── fish/              # fish configuration
├── tmux/              # tmux configuration
├── zellij/            # zellij configuration
├── nvim/              # Neovim configuration
├── helix/             # Helix configuration
├── wezterm/           # WezTerm configuration
├── alacritty/         # Alacritty configuration
├── ghostty/           # Ghostty configuration
├── starship.toml      # Starship prompt config
├── yazi/              # Yazi file manager
├── nnn/               # nnn file manager
├── lf/                # lf file manager
└── ranger/            # ranger file manager
```

## Installation Flow

1. Run `install-all.sh` or individual category scripts
2. Configs are automatically symlinked to `~/.config/`
3. Restart terminal or source shell configs
4. Test each tool individually

## Switching Between Tools

### Shells
```bash
# Switch default shell
chsh -s $(which fish)

# Or just launch in current session
exec fish
```

### Multiplexers
```bash
# Use tmux
tmux

# Use zellij
zellij
```

### Editors
```bash
# Neovim
nvim file.txt

# Helix
hx file.txt
```

## Theme Consistency

All tools support these themes (configs provided):
- **Gruvbox** (warm, retro)
- **Catppuccin** (modern, pastel)
- **Tokyo Night** (dark, vibrant)
- **Nord** (cool, minimal)
- **Dracula** (dark, colorful)

Choose one theme and it's applied across:
- Terminal emulator
- Neovim/Helix
- tmux/zellij
- Starship prompt

## Next Steps

1. Review installation scripts
2. Run `./install-all.sh`
3. Choose a setup combination
4. Test each tool
5. Customize configs as needed

