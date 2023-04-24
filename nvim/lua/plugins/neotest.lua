return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-neotest/neotest-plenary',
    'marilari88/neotest-vitest',
    'nvim-neotest/neotest-vim-test',
    'vim-test/vim-test',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require("neotest-plenary"),
        require("neotest-vitest"),
        require('neotest-vim-test'),
      },
    })
  end,
}
