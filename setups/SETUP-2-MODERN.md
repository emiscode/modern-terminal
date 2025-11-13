# Setup 2: Modern Minimalist

**Best for**: Modern UX, less configuration, built-in features

## Components

- **Shell**: fish
- **Multiplexer**: zellij
- **Editor**: Helix
- **Prompt**: Starship
- **File Explorer**: yazi
- **Fuzzy Finder**: fzf
- **History**: atuin
- **Smart CD**: zoxide

## Installation Steps

1. Install all tools:
   ```bash
   ./scripts/install-all.sh
   ```

2. Setup configurations:
   ```bash
   sudo ./scripts/setup-configs.sh
   ```

3. Switch to fish shell:
   ```bash
   chsh -s $(which fish)
   # Or just: exec fish
   ```

4. Import shell history to atuin:
   ```bash
   atuin import auto
   ```

5. Start zellij:
   ```bash
   zellij
   ```

## Key Bindings

- **zellij**: `Ctrl-g` to enter normal mode
- **Helix**: Modal editor (normal/insert/select modes)
- **fzf**: `Ctrl-R` (history)
- **zoxide**: `z <directory>` (smart cd)

## Workflow

1. Start terminal → fish shell
2. Launch zellij with `zellij`
3. Use `Ctrl-g` to enter zellij normal mode
4. Open files with `hx` (Helix)
5. Navigate with `z` (zoxide)
6. Search history with `Ctrl-R` (atuin)

## Advantages

- Fish: Better autocomplete out of the box
- Zellij: Modern tiling, no plugins needed
- Helix: Built-in LSP, no plugin management
- Less configuration required

## Customization

- Edit `~/.config/fish/config.fish` for fish
- Edit `~/.config/zellij/config.kdl` for zellij
- Edit `~/.config/helix/` for Helix
- Edit `~/.config/starship.toml` for prompt

