# Testing & Validation Guide

Use this checklist to validate your terminal setup.

## Pre-Installation Checks

- [ ] macOS (Apple Silicon or Intel)
- [ ] Homebrew installed
- [ ] Git installed
- [ ] Terminal emulator installed (WezTerm, Alacritty, or Ghostty)

## Installation Validation

### 1. Core Tools

```bash
# Check Homebrew
brew --version

# Check Git
git --version

# Check Nerd Fonts
ls ~/Library/Fonts | grep -i nerd
```

- [ ] Homebrew working
- [ ] Git working
- [ ] Nerd Fonts installed

### 2. Shells

```bash
# Check zsh
zsh --version
echo $SHELL

# Check fish
fish --version

# Check Oh My Zsh
ls ~/.oh-my-zsh

# Check Antidote
antidote --version
```

- [ ] zsh installed
- [ ] fish installed
- [ ] Oh My Zsh installed
- [ ] Antidote installed

### 3. Editors

```bash
# Check Neovim
nvim --version

# Check Helix
hx --version
```

- [ ] Neovim installed
- [ ] Helix installed

### 4. Multiplexers

```bash
# Check tmux
tmux -V

# Check zellij
zellij --version
```

- [ ] tmux installed
- [ ] zellij installed

### 5. Development Tools

```bash
# Check Starship
starship --version

# Check fzf
fzf --version

# Check zoxide
zoxide --version

# Check atuin
atuin --version

# Check LazyGit
lazygit --version

# Check modern CLI tools
rg --version
fd --version
bat --version
eza --version
```

- [ ] Starship installed
- [ ] fzf installed
- [ ] zoxide installed
- [ ] atuin installed
- [ ] LazyGit installed
- [ ] Modern CLI tools installed

## Configuration Validation

### 1. Shell Configuration

```bash
# Test zsh config
zsh -c "source ~/.zshrc; echo 'zsh config loaded'"

# Test fish config
fish -c "echo 'fish config loaded'"
```

- [ ] zsh config loads without errors
- [ ] fish config loads without errors

### 2. Prompt (Starship)

```bash
# Test Starship
starship config schema

# Check Starship in shell
# Should show styled prompt
```

- [ ] Starship prompt displays correctly
- [ ] Icons show correctly (Nerd Fonts)
- [ ] Git status shows in prompt

### 3. Tool Integrations

```bash
# Test fzf
echo "test" | fzf

# Test zoxide
zoxide query -l

# Test atuin
atuin search test
```

- [ ] fzf works
- [ ] zoxide works
- [ ] atuin works

### 4. Editor Configuration

```bash
# Test Neovim
nvim --headless -c "lua print('Neovim config OK')" -c "qa"

# Test Helix
hx --health
```

- [ ] Neovim opens without errors
- [ ] Helix opens without errors
- [ ] Neovim plugins load (check with `:Lazy`)

### 5. Multiplexer Configuration

```bash
# Test tmux
tmux new-session -d -s test
tmux kill-session -t test

# Test zellij
zellij --version
```

- [ ] tmux starts without errors
- [ ] zellij starts without errors

## Functional Testing

### 1. Shell Features

**zsh**:
- [ ] Syntax highlighting works
- [ ] Autosuggestions work
- [ ] History search works (`Ctrl-R`)
- [ ] Tab completion works

**fish**:
- [ ] Autocomplete works
- [ ] Syntax highlighting works
- [ ] History search works

### 2. Fuzzy Finder (fzf)

```bash
# Test file search
fzf

# Test history search (in shell)
# Press Ctrl-R
```

- [ ] File search works
- [ ] History search works
- [ ] Preview works

### 3. Smart Navigation

```bash
# Test zoxide
cd ~
z Documents
# Should jump to Documents

# Test atuin
# Press Ctrl-R and search
```

- [ ] zoxide navigation works
- [ ] atuin history search works

### 4. Editors

**Neovim**:
```bash
nvim test.txt
# Test:
# - File tree: Space e
# - Find files: Space ff
# - LSP: gd (go to definition)
```

- [ ] Neovim opens
- [ ] File tree works
- [ ] Telescope works
- [ ] LSP works (if language server installed)

**Helix**:
```bash
hx test.txt
# Test:
# - Normal mode: Escape
# - Insert mode: i
# - LSP: Space k (hover)
```

- [ ] Helix opens
- [ ] Modes work
- [ ] LSP works

### 5. Multiplexers

**tmux**:
```bash
tmux
# Test:
# - Split: Ctrl-a |
# - Navigate: Ctrl-a h/j/k/l
# - New window: Ctrl-a c
```

- [ ] tmux starts
- [ ] Key bindings work
- [ ] Panes work
- [ ] Windows work

**zellij**:
```bash
zellij
# Test:
# - Normal mode: Ctrl-g
# - Split: s
# - Navigate: h/j/k/l
```

- [ ] zellij starts
- [ ] Key bindings work
- [ ] Panes work
- [ ] Tabs work

### 6. Git Tools

```bash
# Test LazyGit
lazygit

# Test delta (if configured)
git diff

# Test GitHub CLI
gh --version
```

- [ ] LazyGit works
- [ ] Delta works (if configured)
- [ ] GitHub CLI works

### 7. File Explorers

```bash
# Test nnn
nnn

# Test yazi
yazi

# Test ranger
ranger
```

- [ ] File explorers open
- [ ] Navigation works
- [ ] File opening works

## Theme Validation

### 1. Terminal Emulator

- [ ] Colors match Catppuccin Mocha
- [ ] Font is Nerd Font
- [ ] Icons display correctly

### 2. Editors

- [ ] Neovim theme is Catppuccin
- [ ] Helix theme is Catppuccin
- [ ] Colors consistent

### 3. Multiplexers

- [ ] tmux theme matches
- [ ] zellij theme matches

### 4. Prompt

- [ ] Starship colors match
- [ ] Icons display correctly

## Common Issues & Solutions

### Issue: Icons not showing

**Solution**:
1. Install Nerd Fonts: `brew install --cask font-jetbrains-mono-nerd-font`
2. Set font in terminal emulator config
3. Restart terminal

### Issue: Completion errors when sourcing zshrc

**Error**: `compinit:527: no such file or directory: /opt/homebrew/share/zsh/site-functions/_wezterm`

**Solution**:
1. **Quick fix**: Run the fix script:
   ```bash
   ./scripts/fix-completions.sh
   ```
   This will remove broken symlinks and verify your zshrc uses `compinit -u`.

2. **Manual fix**: Reinstall the package to regenerate completions:
   ```bash
   brew reinstall --cask wezterm  # or alacritty, ghostty
   ```

3. **Verify**: Check that zshrc uses `compinit -u`:
   ```bash
   grep compinit ~/.zshrc
   ```
   Should show: `compinit -u`

**Note**: The default zshrc config already includes `compinit -u` to prevent these errors.

### Issue: fzf not working

**Solution**:
```bash
$(brew --prefix)/opt/fzf/install
source ~/.zshrc  # or ~/.config/fish/config.fish
```

### Issue: zoxide not working

**Solution**:
```bash
# Check integration in shell config
grep zoxide ~/.zshrc  # or ~/.config/fish/config.fish

# Re-initialize
eval "$(zoxide init zsh)"  # or fish
```

### Issue: atuin not working

**Solution**:
```bash
# Re-initialize
atuin init zsh  # or fish
source ~/.zshrc
```

### Issue: Neovim LSP not working

**Solution**:
1. Open Neovim
2. Run `:Mason`
3. Install language servers
4. Restart Neovim

### Issue: Theme not matching

**Solution**:
1. Check all config files use same theme name
2. Restart applications
3. Clear terminal cache if needed

## Performance Checks

```bash
# Check shell startup time
time zsh -i -c exit

# Check tool startup times
time nvim --version
time hx --version
```

- [ ] Shell starts quickly (< 1 second)
- [ ] Editors start quickly
- [ ] Tools are responsive

## Final Checklist

- [ ] All tools installed
- [ ] All configs loaded
- [ ] All integrations work
- [ ] Theme is consistent
- [ ] Performance is acceptable
- [ ] Documentation reviewed

## Next Steps

1. Choose a setup combination (see `setups/` directory)
2. Customize configs to your preference
3. Set up atuin sync (optional)
4. Configure LSP servers for your languages
5. Create custom aliases and functions

