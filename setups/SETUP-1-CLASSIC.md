# Setup 1: Classic Power User

**Best for**: Traditional Unix workflow, maximum compatibility, proven tools

## Components

- **Shell**: zsh with Oh My Zsh
- **Multiplexer**: tmux
- **Editor**: Neovim (full LSP setup)
- **Prompt**: Starship
- **File Explorer**: nnn or ranger
- **Fuzzy Finder**: fzf
- **History**: atuin
- **Smart CD**: zoxide

## Installation Steps

1. Install core tools:
   ```bash
   ./scripts/install-core.sh
   ./scripts/install-shells.sh
   ./scripts/install-editors.sh
   ./scripts/install-devtools.sh
   ```

2. Setup configurations:
   ```bash
   sudo ./scripts/setup-configs.sh
   ```

3. Install tmux plugin manager (TPM):
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

4. Start tmux and install plugins:
   ```bash
   tmux
   # Press Ctrl-a then I to install plugins
   ```

5. Import shell history to atuin:
   ```bash
   atuin import auto
   ```

6. Fix completion errors (if any):
   ```bash
   ./scripts/fix-completions.sh
   ```

7. Reload shell:
   ```bash
   source ~/.zshrc
   ```

## Key Bindings

- **tmux prefix**: `Ctrl-a`
- **Neovim leader**: `Space`
- **fzf**: `Ctrl-R` (history), `Ctrl-T` (files)
- **zoxide**: `z <directory>` (smart cd)

## Workflow

1. Start terminal → tmux session
2. Use `Ctrl-a` prefix for tmux commands
3. Open files with `nvim` or `v` alias
4. Navigate with `z` (zoxide) or `fzf`
5. Search history with `Ctrl-R` (atuin)

## Customization

- Edit `~/.config/zsh/` for shell customization
- Edit `~/.config/tmux/tmux.conf` for tmux
- Edit `~/.config/nvim/` for Neovim
- Edit `~/.config/starship.toml` for prompt

