# Modern Terminal Setup for macOS

A comprehensive, modular terminal environment setup for macOS developers. Test and compare multiple tools before choosing your perfect combination.

## Features

- 🐚 **Multiple Shells**: zsh, fish, and experimental options
- 📝 **Modern Editors**: Neovim (LSP-ready) and Helix
- 📺 **Multiplexers**: tmux and zellij
- ⭐ **Universal Prompt**: Starship
- 🔍 **Fuzzy Finder**: fzf integration
- 📁 **File Explorers**: nnn, yazi, lf, ranger, xplr
- 🎨 **Consistent Themes**: Catppuccin, Gruvbox, Nord, and more
- 🛠️ **Modern CLI Tools**: bat, eza, ripgrep, fd, and more
- 📦 **Git Tools**: LazyGit, delta, GitHub CLI
- 🔄 **History Sync**: atuin for cross-machine history

## Quick Start

```bash
# Install everything
./scripts/install-all.sh

# Setup configurations
./scripts/setup-configs.sh

# Choose a setup (see setups/ directory)
```

See [QUICKSTART.md](QUICKSTART.md) for detailed instructions.

## Setup Combinations

We provide 4 pre-configured setups:

1. **[Classic Power User](setups/SETUP-1-CLASSIC.md)**: zsh + tmux + Neovim
2. **[Modern Minimalist](setups/SETUP-2-MODERN.md)**: fish + zellij + Helix
3. **[Experimental Mix](setups/SETUP-3-EXPERIMENTAL.md)**: Cutting-edge tools
4. **[Maximum Productivity](setups/SETUP-4-MAXIMUM.md)**: Everything configured

## Directory Structure

```
modern-terminal/
├── scripts/          # Installation scripts
├── configs/          # Configuration files
│   ├── zsh/         # zsh configuration
│   ├── fish/        # fish configuration
│   ├── tmux/        # tmux configuration
│   ├── zellij/      # zellij configuration
│   ├── nvim/        # Neovim configuration
│   ├── helix/       # Helix configuration
│   ├── wezterm/     # WezTerm configuration
│   ├── alacritty/   # Alacritty configuration
│   ├── ghostty/     # Ghostty configuration
│   └── starship.toml # Starship prompt
├── setups/          # Setup combination guides
├── docs/            # Documentation
└── README.md        # This file
```

## Installation Scripts

All scripts are idempotent (safe to run multiple times):

- `install-core.sh` - Core dependencies and Homebrew
- `install-shells.sh` - Shells and frameworks
- `install-editors.sh` - Terminal editors
- `install-devtools.sh` - Development tools
- `install-niche.sh` - Niche/experimental tools
- `install-all.sh` - Master script (runs all)
- `setup-configs.sh` - Symlink configs to ~/.config

## Configuration

All configurations are modular and organized by tool:

- **Shells**: Modular zsh/fish configs with plugin management
- **Editors**: Neovim with LSP, Treesitter, Telescope; Helix with built-in LSP
- **Multiplexers**: tmux with TPM; zellij with layouts
- **Prompt**: Starship with git, directory, language indicators
- **Themes**: Consistent Catppuccin Mocha across all tools

## Tool Integration

Tools are integrated to work together:

- **fzf**: History search, file search, directory navigation
- **zoxide**: Smart `cd` replacement
- **atuin**: Enhanced shell history with sync
- **LazyGit**: Git TUI in tmux/zellij
- **LSP**: Language servers in Neovim/Helix
- **File Explorers**: Integrated with editors

See [docs/INTEGRATION.md](docs/INTEGRATION.md) for details.

## Themes

All tools support consistent theming:

- **Catppuccin Mocha** (default)
- Gruvbox
- Tokyo Night
- Nord
- Dracula

Change themes by updating config files (see individual tool configs).

## Validation

Use the validation checklist to verify your setup:

```bash
# See docs/VALIDATION.md for complete checklist
```

Quick checks:
- [ ] All tools installed
- [ ] Configs loaded
- [ ] Integrations work
- [ ] Theme consistent

## Documentation

- [PLAN.md](PLAN.md) - High-level overview and philosophy
- [QUICKSTART.md](QUICKSTART.md) - Quick start guide
- [docs/INTEGRATION.md](docs/INTEGRATION.md) - Tool integration guide
- [docs/VALIDATION.md](docs/VALIDATION.md) - Testing checklist
- [setups/](setups/) - Setup combination guides

## Requirements

- macOS (Apple Silicon or Intel)
- Homebrew (installed automatically if missing)
- Terminal emulator (WezTerm, Alacritty, or Ghostty recommended)

## Customization

All configs are in `~/.config/` and can be customized:

1. Edit config files directly
2. Changes persist (configs are symlinked)
3. Restart applications to apply changes

## Troubleshooting

See [docs/VALIDATION.md](docs/VALIDATION.md) for common issues:

- Icons not showing → Install Nerd Fonts
- fzf not working → Run fzf install script
- LSP not working → Install via Mason in Neovim
- Theme not matching → Check all configs use same theme

## Philosophy

- **Modular**: Each tool has its own config directory
- **Testable**: Easy to switch between alternatives
- **Git-friendly**: All configs are version-controlled
- **Idempotent**: Installation scripts can be run multiple times

## Contributing

This is a personal setup, but feel free to:
- Fork and customize
- Report issues
- Suggest improvements

## License

All tools are open source. Check individual tool licenses.

## Acknowledgments

Built with:
- [Neovim](https://neovim.io/)
- [Helix](https://helix-editor.com/)
- [tmux](https://tmux.github.io/)
- [zellij](https://zellij.dev/)
- [Starship](https://starship.rs/)
- [fzf](https://github.com/junegunn/fzf)
- And many more amazing open source tools!

