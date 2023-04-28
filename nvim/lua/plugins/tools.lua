return {
  {
    'laytan/cloak.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
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
  -- tpope
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  { 'tpope/vim-surround', event = 'VeryLazy' },
  {
    'moll/vim-bbye',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'windwp/nvim-autopairs',
    event = { 'BufReadPre', 'BufNewFile' },
  },
}
