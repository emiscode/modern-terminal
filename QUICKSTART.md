# Quick Start Guide

Get your modern terminal setup running in minutes!

## Prerequisites

- macOS (Apple Silicon or Intel)
- Homebrew (will be installed if missing)
- Terminal emulator (WezTerm, Alacritty, or Ghostty recommended)

## Installation

### Option 1: Install Everything

```bash
cd modern-terminal
./scripts/install-all.sh
sudo ./scripts/setup-configs.sh
```

### Option 2: Install Step by Step

```bash
# 1. Core dependencies
./scripts/install-core.sh

# 2. Shells
./scripts/install-shells.sh

# 3. Editors
./scripts/install-editors.sh

# 4. Development tools
./scripts/install-devtools.sh

# 5. Setup configurations
sudo ./scripts/setup-configs.sh
```

## Choose Your Setup

After installation, choose a setup combination:

1. **Classic Power User** (`setups/SETUP-1-CLASSIC.md`)
   - zsh + tmux + Neovim
   - Traditional Unix workflow

2. **Modern Minimalist** (`setups/SETUP-2-MODERN.md`)
   - fish + zellij + Helix
   - Modern UX, less config

3. **Experimental Mix** (`setups/SETUP-3-EXPERIMENTAL.md`)
   - Try cutting-edge tools
   - nushell, yazi, etc.

4. **Maximum Productivity** (`setups/SETUP-4-MAXIMUM.md`)
   - Everything configured
   - Full LSP, all tools

## Post-Installation

### 1. Install tmux plugins (if using tmux)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux
# Press Ctrl-a then I to install plugins
```

### 2. Import shell history to atuin

```bash
atuin import auto
```

### 3. Setup atuin sync (optional)

```bash
atuin register
# Follow prompts
```

### 4. Reload shell

```bash
source ~/.zshrc
# Or if using fish:
source ~/.config/fish/config.fish
```

## Verify Installation

Run the validation checklist:

```bash
# Check tools
which nvim hx tmux zellij starship fzf zoxide atuin lazygit

# Test configs
nvim --version
hx --health
tmux -V
```

See `docs/VALIDATION.md` for complete checklist.

## Customization

All configs are in `~/.config/`:

- `~/.config/zsh/` - zsh configuration
- `~/.config/fish/` - fish configuration
- `~/.config/tmux/` - tmux configuration
- `~/.config/zellij/` - zellij configuration
- `~/.config/nvim/` - Neovim configuration
- `~/.config/helix/` - Helix configuration
- `~/.config/starship.toml` - Starship prompt

## Next Steps

1. Choose a setup combination from `setups/`
2. Read integration guide: `docs/INTEGRATION.md`
3. Customize configs to your preference
4. Install LSP servers for your languages
5. Set up atuin sync for history across machines

## Troubleshooting

### Completion Errors

If you see errors when sourcing zshrc like:
```
compinit:527: no such file or directory: /opt/homebrew/share/zsh/site-functions/_wezterm
```

Run the fix script:
```bash
./scripts/fix-completions.sh
```

This will:
- Remove broken completion symlinks
- Offer to reinstall packages to regenerate completions
- Verify your zshrc uses `compinit -u` (which ignores missing files)

### Other Issues

See `docs/VALIDATION.md` for complete troubleshooting guide.

## Documentation

- `PLAN.md` - High-level overview
- `setups/` - Setup combinations
- `docs/INTEGRATION.md` - Tool integration guide
- `docs/VALIDATION.md` - Testing checklist

## Support

All tools are open source. Check individual tool documentation for advanced usage.

