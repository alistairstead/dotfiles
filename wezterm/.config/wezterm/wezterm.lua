--
-- ██╗    ██╗███████╗███████╗████████╗███████╗██████╗ ███╗   ███╗
-- ██║    ██║██╔════╝╚══███╔╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
-- ██║ █╗ ██║█████╗    ███╔╝    ██║   █████╗  ██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝   ███╔╝     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗███████╗   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
-- A GPU-accelerated cross-platform terminal emulator
-- https://wezfurlong.org/wezterm/

local b = require("utils/background")
local f = require("utils/font")
local h = require("utils/helpers")
local k = require("utils/keys")

local wezterm = require("wezterm")
local act = wezterm.action

local config = {
  background = {
    b.get_background(),
  },
  macos_window_background_blur = 15,
  color_scheme = "Catppuccin Mocha",
  font_size = 18,
  line_height = 1.3,
  cell_width = 1.04,
  warn_about_missing_glyphs = true,
  freetype_load_target = "Light",
  use_cap_height_to_scale_fallback_fonts = true,
  -- "Monaspace Argon",
  -- "Monaspace Krypton",
  -- "Monaspace Neon",
  -- "Monaspace Radon",
  -- "Monaspace Xenon",
  font = f.font_with_fallback("Monaspace Neon", "ExtraLight"),
  font_rules = {
    -- {
    --   intensity = "Bold",
    --   italic = false,
    --   font = wezterm.font({
    --     family = "Monaspace Neon",
    --     weight = "Regular",
    --   }),
    -- },
    -- {
    --   italic = false,
    --   intensity = "Half",
    --   font = wezterm.font({
    --     family = "Monaspace Neon",
    --     weight = "ExtraLight",
    --   }),
    -- },
    -- {
    --   italic = false,
    --   intensity = "Normal",
    --   font = wezterm.font({
    --     family = "Monaspace Neon",
    --     weight = "ExtraLight",
    --   }),
    -- },
    {
      intensity = "Bold",
      italic = true,
      font = wezterm.font({
        family = "Monaspace Radon",
        weight = "Regular",
        style = "Italic",
      }),
    },
    {
      italic = true,
      intensity = "Half",
      font = wezterm.font({
        family = "Monaspace Radon",
        weight = "ExtraLight",
        style = "Italic",
      }),
    },
    {
      italic = true,
      intensity = "Normal",
      font = wezterm.font({
        family = "Monaspace Radon",
        weight = "ExtraLight",
        style = "Italic",
      }),
    },
  },

  window_padding = {
    left = 30,
    right = 30,
    top = 20,
    bottom = 20,
  },

  set_environment_variables = {
    -- THEME_FLAVOUR = "latte",
    BAT_THEME = h.is_dark() and "Catppuccin-mocha" or "Catppuccin-latte",
    TERM = "xterm-256color",
  },

  -- general options
  adjust_window_size_when_changing_font_size = false,
  debug_key_events = true,
  enable_tab_bar = false,
  native_macos_fullscreen_mode = true,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  -- fix left alt key to type special characters such as #
  send_composed_key_when_left_alt_is_pressed = true,
  -- keys
  keys = {
    k.cmd_key(".", k.multiple_actions(":ZenMode")),
    k.cmd_key("[", act.SendKey({ mods = "CTRL", key = "o" })),
    k.cmd_key("]", act.SendKey({ mods = "CTRL", key = "i" })),
    k.cmd_key("H", act.SendKey({ mods = "CTRL", key = "h" })),
    k.cmd_key("J", act.SendKey({ mods = "CTRL", key = "j" })),
    k.cmd_key("K", act.SendKey({ mods = "CTRL", key = "k" })),
    k.cmd_key("L", act.SendKey({ mods = "CTRL", key = "l" })),
    k.cmd_key("P", k.multiple_actions(":GoToCommand")),
    k.cmd_key("p", k.multiple_actions(":GoToFile")),
    k.cmd_key("j", k.multiple_actions(":GoToFile")),
    k.cmd_key("q", k.multiple_actions(":qa!")),
    k.cmd_to_tmux_prefix("1", "1"),
    k.cmd_to_tmux_prefix("2", "2"),
    k.cmd_to_tmux_prefix("3", "3"),
    k.cmd_to_tmux_prefix("4", "4"),
    k.cmd_to_tmux_prefix("5", "5"),
    k.cmd_to_tmux_prefix("6", "6"),
    k.cmd_to_tmux_prefix("7", "7"),
    k.cmd_to_tmux_prefix("8", "8"),
    k.cmd_to_tmux_prefix("9", "9"),
    k.cmd_to_tmux_prefix("`", "n"),
    k.cmd_to_tmux_prefix("b", "B"),
    k.cmd_to_tmux_prefix("C", "C"),
    k.cmd_to_tmux_prefix("d", "D"),
    k.cmd_to_tmux_prefix("G", "G"),
    k.cmd_to_tmux_prefix("g", "g"),
    k.cmd_to_tmux_prefix("k", "T"),
    k.cmd_to_tmux_prefix("l", "L"),
    k.cmd_to_tmux_prefix("N", '"'),
    k.cmd_to_tmux_prefix("n", "%"),
    k.cmd_to_tmux_prefix("o", "u"),
    k.cmd_to_tmux_prefix("r", "$"),
    k.cmd_to_tmux_prefix("T", "!"),
    k.cmd_to_tmux_prefix("t", "c"),
    k.cmd_to_tmux_prefix("w", "x"),
    k.cmd_to_tmux_prefix("f", "z"),

    k.cmd_key(
      "R",
      act.Multiple({
        act.SendKey({ key = "\x1b" }), -- escape
        k.multiple_actions(":source %"),
      })
    ),

    k.cmd_key(
      "s",
      act.Multiple({
        act.SendKey({ key = "\x1b" }), -- escape
        k.multiple_actions(":w"),
      })
    ),

    {
      mods = "CMD|SHIFT",
      key = "}",
      action = act.Multiple({
        act.SendKey({ mods = "CTRL", key = "b" }),
        act.SendKey({ key = "n" }),
      }),
    },
    {
      mods = "CMD|SHIFT",
      key = "{",
      action = act.Multiple({
        act.SendKey({ mods = "CTRL", key = "b" }),
        act.SendKey({ key = "p" }),
      }),
    },

    {
      mods = "CTRL",
      key = "Tab",
      action = act.Multiple({
        act.SendKey({ mods = "CTRL", key = "b" }),
        act.SendKey({ key = "n" }),
      }),
    },

    {
      mods = "CTRL|SHIFT",
      key = "Tab",
      action = act.Multiple({
        act.SendKey({ mods = "CTRL", key = "b" }),
        act.SendKey({ key = "n" }),
      }),
    },

    -- FIX: disable binding
    -- {
    -- 	mods = "CMD",
    -- 	key = "`",
    -- 	action = act.Multiple({
    -- 		act.SendKey({ mods = "CTRL", key = "b" }),
    -- 		act.SendKey({ key = "n" }),
    -- 	}),
    -- },

    {
      mods = "CMD",
      key = "~",
      action = act.Multiple({
        act.SendKey({ mods = "CTRL", key = "b" }),
        act.SendKey({ key = "p" }),
      }),
    },
  },
}

return config
