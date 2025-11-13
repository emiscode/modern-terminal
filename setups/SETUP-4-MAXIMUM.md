# Setup 4: Maximum Productivity

**Best for**: Power users who want everything, maximum customization

## Components

- **Shell**: zsh with Antidote (lightweight plugin manager)
- **Multiplexer**: tmux with TPM plugins
- **Editor**: Neovim (full LSP, Treesitter, Telescope)
- **Prompt**: Starship (fully customized)
- **File Explorer**: yazi (with preview)
- **Fuzzy Finder**: fzf (integrated everywhere)
- **History**: atuin (with sync)
- **Smart CD**: zoxide
- **Git**: lazygit, delta, gh
- **All modern CLI tools**: bat, eza, ripgrep, fd, etc.

## Installation Steps

1. Install everything:
   ```bash
   ./scripts/install-all.sh
   ```

2. Setup configurations:
   ```bash
   ./scripts/setup-configs.sh
   ```

3. Install tmux plugin manager:
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

4. Setup atuin sync (optional):
   ```bash
   atuin register
   # Follow prompts to create account
   ```

5. Install Neovim plugins:
   ```bash
   nvim
   # Lazy.nvim will auto-install plugins
   ```

6. Import history:
   ```bash
   atuin import auto
   ```

## Key Bindings

- **tmux**: `Ctrl-a` prefix
- **Neovim**: `Space` leader
  - `Space e`: File tree
  - `Space ff`: Find files
  - `Space fg`: Live grep
  - `Space fb`: Buffers
- **fzf**: `Ctrl-R`, `Ctrl-T`, `Alt-C`
- **zoxide**: `z`, `zi`, `zoxide query -l`

## Advanced Features

- **LSP**: Full language server support in Neovim
- **Treesitter**: Syntax highlighting and more
- **Telescope**: Powerful fuzzy finder
- **Git integration**: LazyGit, delta for diffs
- **File preview**: yazi with image/text preview
- **History sync**: atuin across machines

## Workflow

1. Start tmux session
2. Use multiple panes for different tasks
3. Open Neovim with full LSP support
4. Use Telescope for file/buffer/grep search
5. Use LazyGit for git operations
6. Use yazi for file management
7. Use fzf for quick searches
8. Use zoxide for smart navigation

## Customization

All configs are modular:
- `~/.config/zsh/` - Shell configs
- `~/.config/tmux/` - Tmux config
- `~/.config/nvim/` - Neovim config
- `~/.config/starship.toml` - Prompt
- `~/.config/yazi/` - File manager

## Tips

- Use tmux sessions for project management
- Use Neovim workspaces for multi-file editing
- Configure LSP servers per project
- Use atuin sync for history across machines
- Customize Starship for your workflow

