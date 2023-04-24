return {
  {
    'levouh/tint.nvim',
    event = {'BufReadPre', 'BufNewFile'},
  },
  {
    'luukvbaal/stabilize.nvim',
    event = {'BufReadPre', 'BufNewFile'},
  },
  { "stevearc/dressing.nvim",      event = "VeryLazy" },
  { 'glepnir/dashboard-nvim' },
  {
    'akinsho/bufferline.nvim',
    -- event = {'BufReadPre', 'BufNewFile'},
  },
  {
    'windwp/windline.nvim',
    event = {'BufReadPre', 'BufNewFile'},
    config = function()
      require('wlsample.airline')
    end,
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = {'BufReadPre', 'BufNewFile'},
  },
  -- the colorscheme should be available when starting Neovim
  { 'projekt0n/github-nvim-theme', lazy = true },
  { 'navarasu/onedark.nvim', lazy = true },
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
