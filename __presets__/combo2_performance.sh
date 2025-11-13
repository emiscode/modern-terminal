#!/bin/bash

###############################################################################
# COMBINATION 2: THE PERFORMANCE STACK
###############################################################################
# Shell: zsh + zinit
# Terminal: Alacritty
# Multiplexer: tmux
# File Manager: lf
# Editor: Neovim
# Fuzzy: fzf
# History: McFly
# Git: lazygit
# Theme: Tokyo Night
###############################################################################

set -e

echo "=================================================="
echo "Installing Combination 2: The Performance Stack"
echo "=================================================="

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo ""
echo "Step 1: Installing core tools..."
echo "=================================="

# zsh should already be installed on macOS
# Install Alacritty
brew install --cask alacritty

# Install tmux
brew install tmux

# Install lf
brew install lf

# Install Neovim
brew install neovim

# Install fzf
brew install fzf
$(brew --prefix)/opt/fzf/install --all

# Install McFly
brew install mcfly

# Install lazygit
brew install lazygit

# Install modern CLI tools
brew install eza bat ripgrep fd zoxide dust duf procs bottom sd
brew install delta glow tldr

echo ""
echo "Step 2: Installing additional dependencies..."
echo "=============================================="

# Install font
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null || echo "TPM already installed"

echo ""
echo "Step 3: Setting up configurations..."
echo "====================================="

# Create config directories
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/lf
mkdir -p ~/.config/nvim
mkdir -p ~/.tmux/plugins

# Install zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Zsh configuration
cat > ~/.zshrc << 'EOF'
# Zinit configuration
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# Load performance-focused plugins
zinit light-mode for \
    zdharma-continuum/fast-syntax-highlighting \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions

# Load OMZ libs we need
zinit snippet OMZL::git.zsh
zinit snippet OMZL::key-bindings.zsh

# Prompt - Powerlevel10k (very fast)
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Initialize completions
autoload -Uz compinit
compinit

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Environment
export EDITOR="nvim"
export VISUAL="nvim"

# Aliases
alias vim="nvim"
alias vi="nvim"
alias ls="eza --icons"
alias ll="eza -l --icons --git"
alias la="eza -la --icons --git"
alias lt="eza --tree --icons"
alias cat="bat"
alias find="fd"
alias grep="rg"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="
--color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7
--color=fg+:#c0caf5,bg+:#292e42,hl+:#7dcfff
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a
--layout=reverse
--border
--height=50%
"

# Zoxide
eval "$(zoxide init zsh)"

# McFly
eval "$(mcfly init zsh)"

# Git aliases
alias lg="lazygit"
alias gst="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"

# lf file manager
alias lf="lfcd"
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}
EOF

# Alacritty configuration (Tokyo Night theme)
cat > ~/.config/alacritty/alacritty.toml << 'EOF'
# Alacritty Configuration - Tokyo Night Theme

[window]
opacity = 0.95
padding = { x = 10, y = 10 }
decorations = "Buttonless"
dynamic_title = true

[scrolling]
history = 10000

[font]
normal = { family = "Hack Nerd Font", style = "Regular" }
bold = { family = "Hack Nerd Font", style = "Bold" }
italic = { family = "Hack Nerd Font", style = "Italic" }
size = 14.0

[cursor]
style = { shape = "Block", blinking = "On" }
blink_interval = 500

[colors.primary]
background = "#1a1b26"
foreground = "#c0caf5"

[colors.normal]
black = "#15161e"
red = "#f7768e"
green = "#9ece6a"
yellow = "#e0af68"
blue = "#7aa2f7"
magenta = "#bb9af7"
cyan = "#7dcfff"
white = "#a9b1d6"

[colors.bright]
black = "#414868"
red = "#f7768e"
green = "#9ece6a"
yellow = "#e0af68"
blue = "#7aa2f7"
magenta = "#bb9af7"
cyan = "#7dcfff"
white = "#c0caf5"

[colors.selection]
text = "CellForeground"
background = "#283457"

[colors.cursor]
text = "CellBackground"
cursor = "#c0caf5"

[[keyboard.bindings]]
key = "N"
mods = "Command"
action = "CreateNewWindow"

[[keyboard.bindings]]
key = "W"
mods = "Command"
action = "Quit"
EOF

# tmux configuration
cat > ~/.tmux.conf << 'EOF'
# Tokyo Night theme for tmux
# Based on https://github.com/folke/tokyonight.nvim

# Terminal settings
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",*256col*:Tc"
set -sg escape-time 0
set -g focus-events on

# Enable mouse
set -g mouse on

# Start windows and panes at 1
set -g base-index 1
setw -g pane-base-index 1

# Renumber windows
set -g renumber-windows on

# Vi mode
setw -g mode-keys vi

# Prefix
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Reload config
bind r source-file ~/.tmux.conf \; display "Config reloaded!"

# Split panes
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# Vim-like pane navigation
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Resize panes
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# Copy mode
bind [ copy-mode
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send -X copy-pipe-and-cancel "pbcopy"

# Tokyo Night colors
set -g mode-style "fg=#7aa2f7,bg=#3b4261"
set -g message-style "fg=#7aa2f7,bg=#3b4261"
set -g message-command-style "fg=#7aa2f7,bg=#3b4261"
set -g pane-border-style "fg=#3b4261"
set -g pane-active-border-style "fg=#7aa2f7"
set -g status-style "fg=#7aa2f7,bg=#1f2335"
set -g status-left "#[fg=#1d202f,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#1f2335,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#1f2335] #{prefix_highlight} #[fg=#3b4261,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %I:%M %p #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#1d202f,bg=#7aa2f7,bold] #h "
setw -g window-status-activity-style "underscore,fg=#a9b1d6,bg=#1f2335"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#a9b1d6,bg=#1f2335"
setw -g window-status-format "#[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#1f2335,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#1f2335,nobold,nounderscore,noitalics]"

# Plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

# Plugin settings
set -g @resurrect-capture-pane-contents 'on'
set -g @continuum-restore 'on'

# Initialize TPM (keep at bottom)
run '~/.tmux/plugins/tpm/tpm'
EOF

# lf configuration
cat > ~/.config/lf/lfrc << 'EOF'
# lf configuration

# Basic settings
set icons true
set ignorecase true
set preview true
set hidden true
set drawbox true
set scrolloff 5

# Custom functions
cmd open ${{
    case $(file --mime-type "$f" -bL) in
        text/*|application/json) $EDITOR "$f";;
        *) open "$f" ;;
    esac
}}

cmd mkdir ${{
    printf "Directory Name: "
    read ans
    mkdir -p "$ans"
}}

cmd mkfile ${{
    printf "File Name: "
    read ans
    $EDITOR "$ans"
}}

cmd trash ${{
    set -f
    mv $fx ~/.Trash
}}

# Bindings
map d trash
map D delete
map a mkdir
map A mkfile
map <enter> open
map R reload
map x cut
map y copy
map p paste
map <c-r> clear

# Use bat for preview
set previewer ~/.config/lf/preview.sh
EOF

# lf preview script
cat > ~/.config/lf/preview.sh << 'EOF'
#!/bin/bash
case "$1" in
    *.tar*) tar tf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *.pdf) pdftotext "$1" -;;
    *) bat --color=always --style=numbers --line-range=:500 "$1" 2>/dev/null || cat "$1";;
esac
EOF
chmod +x ~/.config/lf/preview.sh

# Neovim configuration (LazyVim-inspired, Tokyo Night)
cat > ~/.config/nvim/init.lua << 'EOF'
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.termguicolors = true

-- Plugins
require("lazy").setup({
  -- Tokyo Night theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "python", "javascript", "typescript", "rust", "go" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files)
      vim.keymap.set("n", "<leader>fg", builtin.live_grep)
      vim.keymap.set("n", "<leader>fb", builtin.buffers)
      vim.keymap.set("n", "<leader>fh", builtin.help_tags)
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "pyright" },
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "tokyonight" },
      })
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
})

-- Keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")
EOF

# Git config for delta
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.light false
git config --global delta.side-by-side true
git config --global merge.conflictstyle diff3
git config --global diff.colorMoved default

echo ""
echo "Step 4: Final setup..."
echo "======================"

# Install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins

echo ""
echo "=================================================="
echo "Installation Complete!"
echo "=================================================="
echo ""
echo "Next steps:"
echo "1. Restart your terminal or source ~/.zshrc"
echo "2. Launch Alacritty as your terminal"
echo "3. First time in zsh, configure Powerlevel10k: p10k configure"
echo "4. Install tmux plugins: prefix + I (Ctrl+a then I)"
echo ""
echo "Quick commands to try:"
echo "  - Launch lf: lf (or lfcd to cd on exit)"
echo "  - Launch nvim: nvim"
echo "  - Launch lazygit: lg or lazygit"
echo "  - Launch tmux: tmux"
echo "  - Fuzzy search: Ctrl+R (McFly) or Ctrl+T (fzf)"
echo ""
echo "Tokyo Night theme has been applied to all tools!"
echo "=================================================="
