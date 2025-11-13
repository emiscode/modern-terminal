# Modern Terminal Setup for MacOS - Complete Guide

## 📦 Four Complete Combinations Ready to Install

This repository contains four carefully curated terminal setups for macOS, each with complete installation scripts and configurations. All setups use only **open source** tools and include both established and cutting-edge options.

---

## 🎯 Quick Start

1. **Choose your combination** based on the comparison below
2. **Download the installation script**
3. **Make it executable**: `chmod +x combo[1-4]_*.sh`
4. **Run the script**: `./combo[1-4]_*.sh`
5. **Follow the post-installation steps** shown at the end

---

## 📊 Combination Comparison

| Feature | Combo 1: Hyper-Modern | Combo 2: Performance | Combo 3: Beginner-Friendly | Combo 4: Classic Modern |
|---------|----------------------|---------------------|---------------------------|------------------------|
| **Target User** | Early adopters | Power users | Newcomers | Traditional users |
| **Learning Curve** | Steep | Moderate | Gentle | Easy |
| **Maturity** | Experimental | Stable | Very stable | Battle-tested |
| **Speed** | Very Fast | Fastest | Fast | Fast |
| **Customization** | High | Very High | Medium | High |
| **Documentation** | Growing | Excellent | Excellent | Extensive |
| **Setup Time** | ~15 min | ~15 min | ~10 min | ~15 min |

---

## 🔧 Detailed Breakdowns

### Combination 1: The Hyper-Modern Stack
**Philosophy**: Cutting-edge tools built with modern languages (Rust, Zig) for maximum performance and future-proofing.

#### Components
- **Shell**: Nushell - Structured data pipelines, modern syntax
- **Terminal**: Ghostty - Brand new, GPU-accelerated (manual install needed)
- **Multiplexer**: Zellij - Rust-based, intuitive UI
- **File Manager**: Yazi - Blazing fast, image preview
- **Editor**: Helix - No plugins needed, great defaults
- **Fuzzy Finder**: fzf - Industry standard
- **History**: Atuin - Sync across machines, searchable
- **Git TUI**: gitui - Fast, keyboard-driven
- **Theme**: Catppuccin - Modern pastel aesthetic

#### Best For
- Developers who love trying new tools
- Those who want structured data in shell
- Users comfortable with rapid changes
- People who value cutting-edge features

#### Pros
- Latest features and innovations
- Very fast performance
- Modern, cohesive design
- Active development

#### Cons
- Less mature, may have bugs
- Smaller communities
- Breaking changes possible
- Some tools need manual installation

#### Installation
```bash
chmod +x combo1_hyper_modern.sh
./combo1_hyper_modern.sh
```

---

### Combination 2: The Performance Stack
**Philosophy**: Maximum speed and efficiency with battle-tested tools optimized for performance.

#### Components
- **Shell**: Zsh + zinit - Fast plugin manager, minimal overhead
- **Terminal**: Alacritty - GPU-accelerated, minimal config
- **Multiplexer**: tmux - Rock-solid, extensible
- **File Manager**: lf - Minimal, fast (Go)
- **Editor**: Neovim - Modern Vim with LSP
- **Fuzzy Finder**: fzf - Fast and reliable
- **History**: McFly - Neural network search
- **Git TUI**: lazygit - Simple, powerful
- **Theme**: Tokyo Night - Clean, modern

#### Best For
- Performance-focused developers
- Users who want speed without compromise
- Those comfortable with Vim
- Power users who need efficiency

#### Pros
- Blazing fast startup times
- Minimal resource usage
- Highly customizable
- Excellent performance under load

#### Cons
- Steeper learning curve (Vim/Neovim)
- Requires more manual configuration
- Less beginner-friendly

#### Installation
```bash
chmod +x combo2_performance.sh
./combo2_performance.sh
```

---

### Combination 3: The Beginner-Friendly Stack
**Philosophy**: Easy to learn, intuitive defaults, great for users new to advanced terminal setups.

#### Components
- **Shell**: Fish - Friendly syntax, auto-suggestions built-in
- **Terminal**: WezTerm - Feature-rich, easy config
- **Multiplexer**: Zellij - Intuitive keybindings
- **File Manager**: Yazi - Visual, easy to navigate
- **Editor**: Micro - Simple, familiar keybindings (Ctrl+S, Ctrl+Q)
- **Fuzzy Finder**: fzf - Standard tool
- **History**: Atuin - User-friendly search
- **Git TUI**: lazygit - Visual, easy to learn
- **Theme**: Gruvbox - Warm, easy on eyes

#### Best For
- Terminal newcomers
- Users transitioning from GUI
- Those who want sensible defaults
- People who value ease of use

#### Pros
- Very easy to learn
- Great out-of-box experience
- Intuitive keybindings
- Excellent documentation
- Auto-suggestions everywhere

#### Cons
- Less customization depth
- Some performance trade-offs
- Fish shell syntax different from bash

#### Installation
```bash
chmod +x combo3_beginner_friendly.sh
./combo3_beginner_friendly.sh
```

---

### Combination 4: The Classic Modern Stack
**Philosophy**: Time-tested tools with modern enhancements - the safe, proven choice.

#### Components
- **Shell**: Zsh + Oh My Zsh - Most popular, huge ecosystem
- **Terminal**: iTerm2 - macOS classic, feature-complete
- **Multiplexer**: tmux - Industry standard
- **File Manager**: ranger - Vi-like, Python-based
- **Editor**: Neovim - Modern Vim
- **Fuzzy Finder**: fzf - Reliable standard
- **History**: hstr - Simple, effective
- **Git TUI**: tig - Mature, stable
- **Theme**: Gruvbox - Popular retro aesthetic

#### Best For
- Users who want proven tools
- Those seeking extensive documentation
- Developers who value stability
- People familiar with Unix traditions

#### Pros
- Massive community support
- Extensive documentation
- Proven stability
- Huge plugin ecosystem
- Easy to find help online

#### Cons
- Slightly slower startup
- Can be over-configured
- Some legacy complexity

#### Installation
```bash
chmod +x combo4_classic_modern.sh
./combo4_classic_modern.sh
```

---

## 🎨 Theme Comparison

### Catppuccin (Combo 1)
- Modern pastel colors
- Four flavors (using Mocha)
- Easy on eyes for long sessions
- Growing in popularity

### Tokyo Night (Combo 2)
- Inspired by Tokyo at night
- Vibrant but not harsh
- Excellent contrast
- Popular in developer community

### Gruvbox (Combos 3 & 4)
- Retro groove aesthetic
- Warm, earthy colors
- Very popular, widely supported
- Two variants (using Dark)

---

## 📝 Common Tools Across All Setups

All combinations include these modern CLI replacements:

- **eza**: Better `ls` with icons and git integration
- **bat**: Better `cat` with syntax highlighting
- **ripgrep (rg)**: Faster `grep`
- **fd**: Better `find`
- **zoxide**: Smarter `cd` with frecency
- **delta**: Better git diff viewer
- **bottom/btop**: Better system monitoring
- **dust**: Better `du`
- **duf**: Better `df`
- **tldr**: Simplified man pages

---

## 🚀 Installation Process

Each script will:
1. Install Homebrew (if needed)
2. Install all core tools
3. Install dependencies and fonts
4. Create configuration files
5. Apply themes
6. Set up integrations
7. Display next steps

### System Requirements
- macOS 10.15 or later
- ~2GB free disk space
- Internet connection
- Xcode Command Line Tools (auto-installed)

### Estimated Time
- Download & Install: 10-15 minutes
- Configuration: Automatic
- Learning curve: Varies by combination

---

## 🔄 Switching Between Combinations

You can safely test multiple combinations:

1. Each script backs up existing configs
2. Configs are in `~/.config/` directories
3. To switch, just run a different script
4. Old configs saved with timestamps

---

## 🛠 Post-Installation

### All Combinations
1. Restart your terminal
2. Follow the specific steps shown by the script
3. Read the tool-specific documentation
4. Customize to your preferences

### Shell Changes
To change your default shell:
```bash
# For Fish (Combo 3)
chsh -s /opt/homebrew/bin/fish

# For Nushell (Combo 1)
chsh -s /opt/homebrew/bin/nu

# Back to Zsh (Combos 2 & 4)
chsh -s /bin/zsh
```

---

## 📚 Learning Resources

### General Terminal Skills
- [The Art of Command Line](https://github.com/jlevy/the-art-of-command-line)
- [Bash Guide](https://mywiki.wooledge.org/BashGuide)
- [Terminal Tricks](https://www.youtube.com/c/ThePrimeagen)

### Tool-Specific
- **Neovim**: [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- **Helix**: [Official Docs](https://docs.helix-editor.com/)
- **tmux**: [tmux Guide](https://github.com/tmux/tmux/wiki)
- **Zellij**: [Official Docs](https://zellij.dev/documentation/)

---

## 🐛 Troubleshooting

### Homebrew Issues
```bash
# Update Homebrew
brew update
brew upgrade
brew doctor
```

### Permission Issues
```bash
# Fix Homebrew permissions
sudo chown -R $(whoami) $(brew --prefix)/*
```

### Shell Not Changing
```bash
# Check available shells
cat /etc/shells

# Add your shell if missing
echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
```

### Config Not Loading
```bash
# Source your config manually
source ~/.zshrc  # for zsh
source ~/.config/fish/config.fish  # for fish
```

---

## 🎯 Quick Command Reference

### File Navigation
```bash
# All combos
ls, ll, la, lt  # Enhanced listing
z <partial>     # Jump to directory (zoxide)

# With file managers
yazi / ya       # Open yazi (Combos 1 & 3)
ranger / rcd    # Open ranger (Combo 4)
lf              # Open lf (Combo 2)
```

### Git Operations
```bash
# TUI tools
lazygit / lg    # Visual git interface (Combos 2 & 3)
gitui           # Fast git TUI (Combo 1)
tig / tg        # Git browser (Combo 4)

# Delta diff
git diff        # Automatically uses delta
```

### Fuzzy Finding
```bash
Ctrl+T          # Find files
Ctrl+R          # Search history
Alt+C           # Change directory (Combos 2 & 4)
```

### Editing
```bash
# Combo 1
hx <file>       # Helix editor

# Combos 2 & 4
nvim <file>     # Neovim

# Combo 3
micro <file>    # Micro editor
```

---

## 💡 Pro Tips

### Combo 1 (Hyper-Modern)
- Learn Nushell's structured data: `ls | where size > 1mb`
- Use Helix's multi-cursor: `C` for cursors
- Explore Zellij's floating panes

### Combo 2 (Performance)
- Master tmux sessions: `tmux new -s name`
- Learn Neovim's Telescope: `<leader>ff`
- Use lazygit for all git operations

### Combo 3 (Beginner-Friendly)
- Fish auto-suggestions: press `→` to accept
- WezTerm splits: `Cmd+D` horizontal, `Cmd+Shift+D` vertical
- Yazi preview: press `i` for image preview

### Combo 4 (Classic Modern)
- Configure Powerlevel10k: `p10k configure`
- Oh My Zsh aliases: `alias` to see all
- Ranger bookmarks: `m` to mark, `'` to jump

---

## 🤝 Contributing

Found an issue or have an improvement? Feel free to:
- Report bugs
- Suggest new tools
- Share your configurations
- Improve documentation

---

## 📄 License

All scripts and configurations are provided as-is. Individual tools have their own licenses. See respective project repositories for details.

---

## 🙏 Acknowledgments

Thanks to the maintainers and communities behind:
- All the amazing open-source tools
- The Homebrew team
- Theme creators
- Documentation writers

---

## 🔗 Useful Links

### Official Tool Websites
- [Homebrew](https://brew.sh/)
- [Nushell](https://www.nushell.sh/)
- [Fish Shell](https://fishshell.com/)
- [Neovim](https://neovim.io/)
- [Helix](https://helix-editor.com/)
- [Alacritty](https://alacritty.org/)
- [WezTerm](https://wezfurlong.org/wezterm/)
- [tmux](https://github.com/tmux/tmux)
- [Zellij](https://zellij.dev/)
- [Oh My Zsh](https://ohmyz.sh/)

### Theme Repositories
- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [Tokyo Night](https://github.com/folke/tokyonight.nvim)
- [Gruvbox](https://github.com/morhetz/gruvbox)

---

## ❓ FAQ

**Q: Can I mix and match tools from different combinations?**
A: Yes! Each tool is independent. The scripts just provide cohesive starting points.

**Q: Which combination should I choose?**
A: 
- New to terminals? → Combo 3
- Want maximum performance? → Combo 2
- Love new tech? → Combo 1
- Want proven tools? → Combo 4

**Q: Will this break my existing setup?**
A: No. Scripts backup existing configs with timestamps.

**Q: Can I uninstall everything?**
A: Yes. Use `brew uninstall <tool>` and delete config directories.

**Q: Do I need to know Vim?**
A: Not for Combos 1 & 3 (Helix/Micro). Combos 2 & 4 use Neovim.

**Q: How much disk space needed?**
A: Approximately 1-2 GB including all tools and dependencies.

**Q: Can I use these on Linux?**
A: Scripts are macOS-specific, but tool choices work on Linux with different package managers.

---

**Happy Terminal Customizing! 🎉**

Choose your combination, run the script, and enjoy a modern terminal experience!
