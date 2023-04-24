return {
  {
    'laytan/cloak.nvim',
    event = {'BufReadPre', 'BufNewFile'},
  },
  {
    'editorconfig/editorconfig-vim',
    event = {'BufReadPre', 'BufNewFile'},
    init = function()
      vim.g.EditorConfig_max_line_indicator = ''
      vim.g.EditorConfig_preserve_formatoptions = 1
    end,
  },
  -- tpope
  'knubie/vim-kitty-navigator',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-fugitive',
  'tpope/vim-sleuth',
  -- Primeagen doesn"t create lodash
  'ThePrimeagen/git-worktree.nvim',
  'ThePrimeagen/refactoring.nvim',
  'moll/vim-bbye',
  {
    'windwp/nvim-autopairs',
    event = {'BufReadPre', 'BufNewFile'},
  }
}
