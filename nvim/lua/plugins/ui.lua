return {
  {
    'luukvbaal/stabilize.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'stevearc/dressing.nvim',
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    'glepnir/dashboard-nvim',
    opts = {
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Apps',
            group = 'DiagnosticHint',
            action = 'Telescope app',
            key = 'a',
          },
          {
            desc = ' dotfiles',
            group = 'Number',
            action = 'Telescope dotfiles',
            key = 'd',
          },
        },
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
    },
    opts = {
      options = {
        -- stylua: ignore
        -- close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        -- right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        -- diagnostics_indicator = function(_, _, diag)
        --   local icons = require("lazyvim.config").icons.diagnostics
        --   local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        --     .. (diag.warning and icons.Warn .. diag.warning or "")
        --   return vim.trim(ret)
        -- end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
  },
  {
    'windwp/windline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('wlsample.airline')
    end,
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  -- the colorscheme should be available when starting Neovim
  { 'projekt0n/github-nvim-theme', lazy = true },
  { 'navarasu/onedark.nvim', lazy = true },
  {
    'folke/tokyonight.nvim',
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      -- vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    'Mofiqul/dracula.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      -- customize dracula color palette
      -- colors = {
      --   bg = '#0B0B0F',
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
      -- },
      -- show the '~' characters after the end of buffers
      show_end_of_buffer = true, -- default false
      -- use transparent background
      transparent_bg = true, -- default false
      -- set custom lualine background color
      lualine_bg_color = '#44475a', -- default nil
      -- set italic comment
      italic_comment = true, -- default false
      -- overrides the default highlights see `:h synIDattr`
      overrides = {
        -- Examples
        -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
        -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
        -- Nothing = {} -- clear highlight of Nothing
        Comment = { fg = '#7970A9' },
        -- VertSplit = { fg = '#454158', bg = '#22212C' },
      },
    },
    config = function(_, opts)
      -- load the colorscheme here
      require('dracula').setup(opts)
      vim.cmd([[colorscheme dracula]])
    end,
  },
}
