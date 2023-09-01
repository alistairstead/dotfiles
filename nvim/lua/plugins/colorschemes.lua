return {
  {
    "mofiqul/dracula.nvim",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = function()
      local colors = require("dracula").colors()
      return {
        -- customize dracula color palette
        colors = {
          bg = "#282a36",
          bg_dark = "#21222c",
          fg = "#f8f8f2",
          selection = "#44475a",
          comment = "#6272a4", -- #7970a9
          red = "#ff5555",
          orange = "#ffb86c",
          yellow = "#f1fa8c",
          green = "#50fa7b",
          purple = "#bd93f9",
          cyan = "#8be9fd",
          pink = "#ff79c6",
          bright_red = "#ff6e6e",
          bright_green = "#69ff94",
          bright_yellow = "#ffffa5",
          bright_blue = "#d6acff",
          bright_magenta = "#ff92df",
          bright_cyan = "#a4ffff",
          bright_white = "#ffffff",
          menu = "#21222c",
          visual = "#3e4452",
          gutter_fg = "#4b5263",
          nontext = "#3b4048",
          white = "#abb2bf",
          black = "#191a21",
        },
        -- show the '~' characters after the end of buffers
        show_end_of_buffer = false, -- default false
        -- use transparent background
        transparent_bg = false, -- default false
        -- set custom lualine background color
        lualine_bg_color = colors.bg_dark, -- default nil
        -- set italic comment
        italic_comment = true, -- default false
        -- overrides the default highlights see `:h synidattr`
        overrides = {
          -- examples
          -- nontext = { fg = dracula.colors().white }, -- set nontext fg to white
          -- nvimtreeindentmarker = { link = "nontext" }, -- link to nontext highlight
          Comment = { fg = colors.comment, italic = true },
          CursorLine = { bg = colors.bg_dark },
          CursorLineNr = { fg = colors.yellow },
          DiffAdd = { bg = "none" },
          DiffChange = { bg = "none" },
          DiffDelete = { bg = "none" },
          GitSignsAdd = { fg = colors.bright_green, bg = "none" },
          GitSignsChange = { fg = colors.orange, bg = "none" },
          GitSignsDelete = { fg = colors.red, bg = "none" },
          Nothing = {}, -- clear highlight of nothing
          VertSplit = { fg = colors.nontext, bg = colors.bg_dark },
          WarnLine = { fg = colors.orange },
          WarningMsg = { fg = colors.orange },
        },
      }
    end,
    config = function(_, opts)
      local dracula = require("dracula")
      dracula.setup(opts)
      -- dracula.load()
    end,
  },
  {
    "code/dracula_pro",
    dependencies = {
      { "mofiqul/dracula.nvim" },
    },
    name = "dracula_pro",
    dev = true,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme dracula_pro")
      local colors = require("util.colors")
      colors.setup()
      colors.update_hl("Comment", { fg = "#7970a9", italic = true })
      colors.update_hl("CursorLine", { bg = "#282a36" })
      colors.inherit_hl("Diffadd", "GitSignsAdd", { bg = "none" })
      colors.inherit_hl("DiffChange", "GitSignsChange", { bg = "none" })
      colors.inherit_hl("DiffDelete", "GitSignsDelete", { bg = "none" })
      colors.update_hl("VertSplit", { fg = "#3b4048", bg = "#21222c" })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "dracula_pro",
    },
  },
}
