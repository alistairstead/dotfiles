return {
  {
    'folke/styler.nvim',
    event = 'VeryLazy',
    enabled = false,
    config = function()
      require('styler').setup({
        themes = {
          markdown = { colorscheme = 'dracula_pro_morbius' },
          help = { colorscheme = 'dracula_pro_morbius' },
        },
      })
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
    priority = 1000,
    opts = {
      colors = {
        -- bg = '#282a36',
        -- bg_dark = '#21222c',
      },
      overrides = {
        Comment = { italic = true },
        VertSplit = { fg = '#454158', bg = '#282a36' },
      },
    },
    config = function(_, opts)
      local tokyonight = require('tokyonight')
      tokyonight.setup(opts)
      -- tokyonight.load()
    end,
  },
  {
    'navarasu/onedark.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'Mofiqul/dracula.nvim',
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      -- customize dracula color palette
      colors = {
        bg = '#282a36',
        bg_dark = '#21222c',
        --   fg = '#F8F8F2',
        --   selection = '#44475A',
        --   comment = '#6272A4',
        --   red = '#FF5555',
        --   orange = '#FFB86C',
        --   yellow = '#F1FA8C',
        --   green = '#50fa7b',
        --   purple = '#BD93F9',
        --   cyan = '#8BE9FD',
        --   pink = '#FF79C6',
        --   bright_red = '#FF6E6E',
        --   bright_green = '#69FF94',
        --   bright_yellow = '#FFFFA5',
        --   bright_blue = '#D6ACFF',
        --   bright_magenta = '#FF92DF',
        --   bright_cyan = '#A4FFFF',
        --   bright_white = '#FFFFFF',
        --   menu = '#21222C',
        --   visual = '#3E4452',
        --   gutter_fg = '#4B5263',
        --   nontext = '#3B4048',
      },
      -- -- show the '~' characters after the end of buffers
      -- -- show_end_of_buffer = true, -- default false
      -- -- use transparent background
      -- transparent_bg = false, -- default false
      -- -- set custom lualine background color
      -- -- lualine_bg_color = '#44475a', -- default nil
      -- -- set italic comment
      -- italic_comment = true, -- default false
      -- -- overrides the default highlights see `:h synIDattr`
      overrides = {
        --   -- Examples
        --   -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
        --   -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
        --   Nothing = {}, -- clear highlight of Nothing
        -- Fine-tune highlights
        DiffAdd = { bg = 'none' },
        GitSignsAdd = { bg = 'none' },
        DiffChange = { bg = 'none' },
        GitSignsChange = { bg = 'none' },
        DiffDelete = { bg = 'none' },
        GitSignsDelete = { bg = 'none' },
        Comment = { fg = '#7970A9', italic = true },
        VertSplit = { fg = '#454158', bg = '#282a36' },
      },
    },
    config = function(_, opts)
      local dracula = require('dracula')
      dracula.setup(opts)
      -- dracula.load()
    end,
  },
  {
    'code/dracula_pro',
    name = 'dracula_pro',
    dev = true,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme dracula_pro')
      local Colors = require('util.colors')
      Colors.setup()
      -- Italicise comments
      Colors.update_hl('Comment', { fg = '#7970A9', italic = true })
      Colors.update_hl('VertSplit', { fg = '#454158', bg = '#22212C' })
      -- Fine-tune highlights
      Colors.inherit_hl('DiffAdd', 'GitSignsAdd', { bg = 'none' })
      Colors.inherit_hl('DiffChange', 'GitSignsChange', { bg = 'none' })
      Colors.inherit_hl('DiffDelete', 'GitSignsDelete', { bg = 'none' })
    end,
  },
}
