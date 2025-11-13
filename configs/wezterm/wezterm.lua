-- WezTerm configuration
-- GPU-accelerated terminal emulator

local wezterm = require("wezterm")

-- Catppuccin Mocha color scheme
local colors = {
  rosewater = "#F5E0DC",
  flamingo = "#F2CDCD",
  pink = "#F5C2E7",
  mauve = "#CBA6F7",
  red = "#F38BA8",
  maroon = "#EBA0AC",
  peach = "#FAB387",
  yellow = "#F9E2AF",
  green = "#A6E3A1",
  teal = "#94E2D5",
  sky = "#89DCEB",
  sapphire = "#74C7EC",
  blue = "#89B4FA",
  lavender = "#B4BEFE",
  text = "#CDD6F4",
  subtext1 = "#BAC2DE",
  subtext0 = "#A6ADC8",
  overlay2 = "#9399B2",
  overlay1 = "#7F849C",
  overlay0 = "#6C7086",
  surface2 = "#585B70",
  surface1 = "#45475A",
  surface0 = "#313244",
  base = "#1E1E2E",
  mantle = "#181825",
  crust = "#11111B",
}

return {
  -- Font configuration
  font = wezterm.font("JetBrains Mono Nerd Font", { weight = "Regular" }),
  font_size = 13.0,
  line_height = 1.2,

  -- Color scheme
  color_scheme = "Catppuccin Mocha",
  colors = {
    foreground = colors.text,
    background = colors.base,
    cursor_bg = colors.text,
    cursor_border = colors.text,
    cursor_fg = colors.base,
    selection_bg = colors.surface0,
    selection_fg = colors.text,
    ansi = {
      colors.crust,
      colors.red,
      colors.green,
      colors.yellow,
      colors.blue,
      colors.mauve,
      colors.teal,
      colors.text,
    },
    brights = {
      colors.surface2,
      colors.red,
      colors.green,
      colors.yellow,
      colors.blue,
      colors.mauve,
      colors.teal,
      colors.subtext1,
    },
    tab_bar = {
      background = colors.crust,
      active_tab = {
        bg_color = colors.base,
        fg_color = colors.text,
      },
      inactive_tab = {
        bg_color = colors.mantle,
        fg_color = colors.overlay1,
      },
      inactive_tab_hover = {
        bg_color = colors.surface0,
        fg_color = colors.text,
      },
      new_tab = {
        bg_color = colors.mantle,
        fg_color = colors.overlay1,
      },
      new_tab_hover = {
        bg_color = colors.surface0,
        fg_color = colors.text,
      },
    },
  },

  -- Window configuration
  window_background_opacity = 1.0,
  window_decorations = "RESIZE",
  window_padding = {
    left = 8,
    right = 8,
    top = 8,
    bottom = 8,
  },

  -- Tab bar
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_max_width = 32,
  use_fancy_tab_bar = true,

  -- Cursor
  default_cursor_style = "BlinkingBlock",
  cursor_blink_rate = 500,

  -- Scrollback
  scrollback_lines = 10000,

  -- Key bindings
  keys = {
    -- Copy
    {
      key = "c",
      mods = "CTRL|SHIFT",
      action = wezterm.action.CopyTo("Clipboard"),
    },
    -- Paste
    {
      key = "v",
      mods = "CTRL|SHIFT",
      action = wezterm.action.PasteFrom("Clipboard"),
    },
    -- New tab
    {
      key = "t",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
    -- Close tab
    {
      key = "w",
      mods = "CTRL|SHIFT",
      action = wezterm.action.CloseCurrentTab({ confirm = true }),
    },
    -- Split horizontally
    {
      key = "-",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    -- Split vertically
    {
      key = "|",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
  },

  -- Default shell
  default_prog = { "/opt/homebrew/bin/zsh", "-l" },

  -- Startup
  initial_cols = 120,
  initial_rows = 30,
}

