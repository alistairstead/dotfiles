return {
  'rcarriga/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'marilari88/neotest-vitest',
  },
  opts = {
    -- adapters = {
    --   require('neotest-vitest'),
    -- },
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-vitest'),
      },
    })
  end,
  keys = {
    {
      '<leader>t',
      function()
        require('neotest').run.run(vim.fn.expand('%'))
      end,
      desc = 'NeoTest - Run the current file',
    },
    {
      '<leader>tt',
      function()
        require('neotest').run.run()
      end,
      desc = 'NeoTest - Run the nearest test',
    },
    {
      '<leader>td',
      function()
        require('neotest').run.run({ strategy = 'dap' })
      end,
      desc = 'NeoTest - Debug the nearest test',
    },
    {
      '<leader>ts',
      function()
        require('neotest').run.stop()
      end,
      desc = 'NeoTest - Stop the nearest test',
    },
    {
      '<leader>ta',
      function()
        require('neotest').run.attach()
      end,
      desc = 'NeoTest - Attach to the nearest test',
    },
    {
      '<leader>tm',
      function()
        require('neotest').summary.marked()
      end,
      desc = 'NeoTest - Summary marked',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'NeoTest - Summary toggle',
    },
  },
}
