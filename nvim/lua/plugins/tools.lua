return {
  {
    'laytan/cloak.nvim',
    event = 'VeryLazy',
  },
  {
    'editorconfig/editorconfig-vim',
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
      vim.g.EditorConfig_max_line_indicator = ''
      vim.g.EditorConfig_preserve_formatoptions = 1
    end,
  },
  {
    'knubie/vim-kitty-navigator',
    keys = {
      { '<C-h>', '<cmd>KittyNavigateLeft<cr>', desc = 'KittyNavigateLeft' },
      { '<C-l>', '<cmd>KittyNavigateRight<cr>', desc = 'KittyNavigateRight' },
      { '<C-j>', '<cmd>KittyNavigateDown<cr>', desc = 'KittyNavigateDown' },
      { '<C-k>', '<cmd>KittyNavigateUp<cr>', desc = 'KittyNavigateUp' },
    },
  },
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
  },
  {
    'moll/vim-bbye',
    cmd = { 'Bdelete', 'Bwipeout' },
    keys = {
      { '<leader>c', '<cmd>Bdelete<cr>', desc = 'Buffer delete' },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
  },
  { 'pwntester/octo.nvim', opts = {}, cmd = 'Octo' },
  -- markdown preview
  {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    ft = 'markdown',
    keys = {
      {
        '<leader>op',
        function()
          local peek = require('peek')
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = 'Peek (Markdown Preview)',
      },
    },
    opts = { theme = 'dark', app = 'browser' },
  },
  {
    'ThePrimeagen/refactoring.nvim',
    keys = {
      {
        '<leader>r',
        function()
          require('refactoring').select_refactor()
        end,
        mode = 'v',
        noremap = true,
        silent = true,
        expr = false,
      },
    },
  },
  -- better diffing
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    config = true,
    keys = { { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'DiffView' } },
  },
}
