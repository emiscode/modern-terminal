# Setup 3: Experimental Mix

**Best for**: Trying cutting-edge tools, exploring alternatives

## Components

- **Shell**: nushell (or fish)
- **Multiplexer**: zellij
- **Editor**: Neovim (or Helix)
- **Prompt**: Starship
- **File Explorer**: yazi or xplr
- **Fuzzy Finder**: fzf or skim
- **History**: atuin
- **Smart CD**: zoxide

## Installation Steps

1. Install all tools including experimental:
   ```bash
   ./scripts/install-all.sh
   # Say yes to experimental shells
   ```

2. Setup configurations:
   ```bash
   sudo ./scripts/setup-configs.sh
   ```

3. Try nushell:
   ```bash
   nu
   ```

4. Configure nushell (if using):
   ```bash
   mkdir -p ~/.config/nu
   # Create config.nu file
   ```

## Key Features

- **nushell**: Structured data, pipelines, modern syntax
- **zellij**: Modern multiplexer with layouts
- **yazi**: Fast, async file manager
- **skim**: Alternative to fzf (written in Rust)

## Workflow

1. Experiment with different shells
2. Use zellij for session management
3. Try both Neovim and Helix
4. Compare file explorers (yazi vs nnn vs xplr)

## Notes

- Some tools may have different syntax
- nushell has different command structure
- May require additional configuration
- Good for learning and comparison

