#!/bin/bash

###############################################################################
# COMBINATION 4: THE CLASSIC MODERN STACK
###############################################################################
# Shell: zsh + Oh My Zsh
# Terminal: iTerm2
# Multiplexer: tmux
# File Manager: ranger
# Editor: Neovim
# Fuzzy: fzf
# History: hstr
# Git: tig
# Theme: Gruvbox
###############################################################################

set -e

echo "=================================================="
echo "Installing Combination 4: The Classic Modern Stack"
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

# Install iTerm2
brew install --cask iterm2

# Install tmux
brew install tmux

# Install ranger
brew install ranger

# Install Neovim
brew install neovim

# Install fzf
brew install fzf
$(brew --prefix)/opt/fzf/install --all

# Install hstr
brew install hstr

# Install tig
brew install tig

# Install modern CLI tools
brew install eza bat ripgrep fd zoxide dust duf procs bottom sd
brew install delta glow tldr tree highlight

echo ""
echo "Step 2: Installing additional dependencies..."
echo "=============================================="

# Install font (fonts are now in main Homebrew cask repository)
brew install --cask font-meslo-lg-nerd-font

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null || echo "TPM already installed"

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo ""
echo "Step 3: Setting up configurations..."
echo "====================================="

# Create config directories
mkdir -p ~/.config/ranger
mkdir -p ~/.config/nvim
mkdir -p ~/.tmux/plugins

# Install Oh My Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null || echo "zsh-autosuggestions already installed"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null || echo "zsh-syntax-highlighting already installed"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting 2>/dev/null || echo "fast-syntax-highlighting already installed"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions 2>/dev/null || echo "zsh-completions already installed"

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k 2>/dev/null || echo "Powerlevel10k already installed"

# Backup existing .zshrc
if [ -f ~/.zshrc ]; then
    cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
fi

# Zsh configuration with Oh My Zsh
cat > ~/.zshrc << 'EOF'
# Oh My Zsh Configuration - Classic Modern Stack

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    fast-syntax-highlighting
    zsh-completions
    colored-man-pages
    copyfile
    copypath
    extract
    web-search
    jsontools
    dirhistory
)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8
export EDITOR='nvim'
export VISUAL='nvim'

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS

# Aliases
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias ls='eza --icons'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'
alias lt='eza --tree --icons'
alias cat='bat'
alias find='fd'
alias grep='rg'
alias top='btop'
alias du='dust'
alias df='duf'
alias ps='procs'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --all --decorate'
alias tg='tig'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Ranger with cd on exit
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}
alias rcd='ranger-cd'
alias r='ranger'

# FZF configuration - Gruvbox theme
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="
--color=bg+:#3c3836,bg:#282828,spinner:#fb4934,hl:#928374
--color=fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934
--color=marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934
--layout=reverse
--border
--height=50%
--preview='bat --style=numbers --color=always --line-range :500 {}'
"

# FZF key bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zoxide (better cd)
eval "$(zoxide init zsh)"
alias cd='z'

# HSTR configuration
export HSTR_CONFIG=hicolor,prompt-bottom
bindkey -s "\C-r" "\C-a hstr -- \C-j"

# Utility functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF

# tmux configuration - Gruvbox theme
cat > ~/.tmux.conf << 'EOF'
# tmux Configuration - Classic Modern with Gruvbox

# Terminal settings
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",*256col*:Tc"
set -sg escape-time 0
set -g focus-events on
set -g history-limit 50000

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

# Split panes using | and -
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
unbind '"'
unbind %

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

# Switch windows
bind -n M-h previous-window
bind -n M-l next-window

# Copy mode
bind [ copy-mode
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send -X copy-pipe-and-cancel "pbcopy"
bind -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe-and-cancel "pbcopy"
bind p paste-buffer

# Gruvbox Dark color scheme
set -g status-position bottom
set -g status-style bg=#3c3836,fg=#ebdbb2
set -g status-left-length 40
set -g status-right-length 150

set -g status-left "#[fg=#282828,bg=#83a598,bold] #S #[fg=#83a598,bg=#3c3836,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#3c3836,bg=#3c3836,nobold,nounderscore,noitalics]#[fg=#a89984,bg=#3c3836] %Y-%m-%d  %H:%M #[fg=#83a598,bg=#3c3836,nobold,nounderscore,noitalics]#[fg=#282828,bg=#83a598,bold] #h "

setw -g window-status-format "#[fg=#3c3836,bg=#3c3836,nobold,nounderscore,noitalics]#[fg=#a89984] #I  #W #[fg=#3c3836,bg=#3c3836,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#3c3836,bg=#504945,nobold,nounderscore,noitalics]#[fg=#ebdbb2,bg=#504945] #I  #W #F #[fg=#504945,bg=#3c3836,nobold,nounderscore,noitalics]"

set -g window-status-separator ""

# Pane borders
set -g pane-border-style fg=#3c3836
set -g pane-active-border-style fg=#83a598

# Message style
set -g message-style bg=#504945,fg=#ebdbb2
set -g message-command-style bg=#504945,fg=#ebdbb2

# Pane number display
set -g display-panes-active-colour "#83a598"
set -g display-panes-colour "#3c3836"

# Clock
setw -g clock-mode-colour "#83a598"

# Copy mode
setw -g mode-style bg=#504945,fg="#ebdbb2"

# Plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @plugin 'tmux-plugins/tmux-pain-control'
set -g @plugin 'tmux-plugins/tmux-copycat'
set -g @plugin 'tmux-plugins/tmux-open'

# Plugin settings
set -g @resurrect-strategy-nvim 'session'
set -g @resurrect-capture-pane-contents 'on'
set -g @continuum-restore 'on'
set -g @continuum-save-interval '15'

# Initialize TPM (keep at bottom)
run '~/.tmux/plugins/tpm/tpm'
EOF

# Ranger configuration
ranger --copy-config=all 2>/dev/null || true

cat > ~/.config/ranger/rc.conf << 'EOF'
# Ranger Configuration - Classic Modern

# Basic settings
set viewmode miller
set column_ratios 1,3,4
set hidden_filter ^\.|\.(?:pyc|pyo|bak|swp)$|^lost\+found$|^__(py)?cache__$
set show_hidden true
set confirm_on_delete multiple
set preview_script ~/.config/ranger/scope.sh
set use_preview_script true
set preview_images true
set preview_images_method iterm2
set vcs_aware true
set vcs_backend_git enabled

# Appearance
set draw_borders both
set dirname_in_tabs true
set mouse_enabled true
set display_size_in_main_column true
set display_size_in_status_bar true
set display_tags_in_all_columns true
set update_title true
set shorten_title 3
set tilde_in_titlebar true

# Colors - Gruvbox
set colorscheme default

# Custom commands
map D console delete
map mkd console mkdir%space
map mkf console touch%space

# Navigation
map gh cd ~
map gc cd ~/.config
map gd cd ~/Downloads
map gD cd ~/Documents

# Open with
map e shell nvim %s
map E shell nvim .

# Sorting
map or set sort_reverse!
map oz set sort=random
map os chain set sort=size; set sort_reverse=False
map ot chain set sort=type; set sort_reverse=False
map om chain set sort=mtime; set sort_reverse=False
map oc chain set sort=ctime; set sort_reverse=False
map oa chain set sort=atime; set sort_reverse=False
map ob chain set sort=basename; set sort_reverse=False
map on chain set sort=natural; set sort_reverse=False

# FZF integration
map <C-f> fzf_select

# Command shortcuts
alias e edit
alias q quit
alias q! quit!
alias qall quitall
alias qall! quitall!
alias setl setlocal
alias filter scout -prts
alias find scout -aets
alias mark scout -mr
alias unmark scout -Mr
alias search scout -rs
alias search_inc scout -rts
alias travel scout -aefklst
EOF

# Ranger commands
cat > ~/.config/ranger/commands.py << 'EOF'
from ranger.api.commands import Command
import os

class fzf_select(Command):
    """
    :fzf_select
    Find a file using fzf.
    """
    def execute(self):
        import subprocess
        if self.quantifier:
            command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -type f -print 2> /dev/null | sed 1d | cut -b3- | fzf +m --reverse --header='Jump to file'"
        else:
            command="find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m --reverse --header='Jump to file'"
        
        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.decode('utf-8').rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)
EOF

# Neovim configuration (similar to Combo 2 but with classic plugins)
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
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Plugins
require("lazy").setup({
  -- Gruvbox theme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = false,
      })
      vim.cmd([[colorscheme gruvbox]])
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

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "python", "javascript", "typescript", "rust", "go", "html", "css" },
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
        ensure_installed = { "lua_ls", "rust_analyzer", "pyright", "tsserver" },
      })
      
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      -- Example LSP setup
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.rust_analyzer.setup({ capabilities = capabilities })
      lspconfig.tsserver.setup({ capabilities = capabilities })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
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

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end,
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
  },
})

-- Keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and quit" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Resize windows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Buffer navigation
vim.keymap.set("n", "<S-l>", ":bnext<CR>")
vim.keymap.set("n", "<S-h>", ":bprevious<CR>")

-- Stay in visual mode when indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
EOF

# Git config for delta - Gruvbox theme
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.light false
git config --global delta.side-by-side true
git config --global delta.line-numbers true
git config --global merge.conflictstyle diff3
git config --global diff.colorMoved default
git config --global delta.syntax-theme "gruvbox-dark"

# HSTR configuration
cat >> ~/.zshrc << 'EOF'

# HSTR configuration - needs to be at the end
export HSTR_CONFIG=hicolor,prompt-bottom
export HSTR_PROMPT="$ "
EOF

echo ""
echo "Step 4: Downloading iTerm2 color scheme..."
echo "==========================================="

# Download Gruvbox color scheme for iTerm2
mkdir -p ~/Downloads/iterm2-colors
curl -L https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Gruvbox%20Dark.itermcolors -o ~/Downloads/iterm2-colors/Gruvbox-Dark.itermcolors

echo ""
echo "Step 5: Final setup..."
echo "======================"

# Install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins

echo ""
echo "=================================================="
echo "Installation Complete!"
echo "=================================================="
echo ""
echo "Next steps:"
echo "1. Launch iTerm2"
echo "2. Import color scheme:"
echo "   - iTerm2 → Settings → Profiles → Colors"
echo "   - Color Presets → Import"
echo "   - Navigate to ~/Downloads/iterm2-colors/Gruvbox-Dark.itermcolors"
echo "   - Select Gruvbox Dark from presets"
echo "3. Change font to MesloLGS NF:"
echo "   - iTerm2 → Settings → Profiles → Text"
echo "   - Font → MesloLGS NF"
echo "4. Restart your terminal"
echo "5. Configure Powerlevel10k: p10k configure"
echo "6. Install tmux plugins: prefix + I (Ctrl+a then I)"
echo ""
echo "Quick commands to try:"
echo "  - Launch ranger: r or rcd (cd on exit)"
echo "  - Launch nvim: nvim or v"
echo "  - Launch tig: tig or tg"
echo "  - Launch tmux: tmux"
echo "  - Search history: Ctrl+R (hstr)"
echo "  - Fuzzy find files: Ctrl+T (fzf)"
echo "  - Fuzzy change dir: Alt+C (fzf)"
echo ""
echo "Oh My Zsh plugins enabled:"
echo "  - git (aliases for git commands)"
echo "  - zsh-autosuggestions (suggestions as you type)"
echo "  - zsh-syntax-highlighting (syntax highlighting)"
echo "  - colored-man-pages (colorful man pages)"
echo "  - extract (extract any archive with 'extract <file>')"
echo ""
echo "Gruvbox theme has been applied to all tools!"
echo "=================================================="
