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
  -- tpope
  'knubie/vim-kitty-navigator',
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  { 'tpope/vim-surround', event = 'VeryLazy' },
  -- Primeagen doesn"t create lodash
  {
    'moll/vim-bbye',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'windwp/nvim-autopairs',
    event = { 'BufReadPre', 'BufNewFile' },
  },
}
