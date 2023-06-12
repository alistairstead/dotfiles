return {
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
    config = function()
      require('nvim-surround').setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
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
  -- {
  --   'kevinhwang91/nvim-ufo',
  --   dependencies = 'kevinhwang91/promise-async',
  --   event = 'BufReadPost',
  --   opts = {},
  --   init = function()
  --     -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
  --     vim.keymap.set('n', 'zR', function()
  --       require('ufo').openAllFolds()
  --     end)
  --     vim.keymap.set('n', 'zM', function()
  --       require('ufo').closeAllFolds()
  --     end)
  --   end,
  -- },
  {
    'echasnovski/mini.splitjoin',
    enabled = false,
    opts = { mappings = { toggle = 'J' } },
    keys = {
      { 'J', desc = 'Split/Join' },
    },
  },
  {
    'Wansmer/treesj',
    keys = {
      { 'J', '<cmd>TSJToggle<cr>', desc = 'Join Toggle' },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    'cshuaimin/ssr.nvim',
    keys = {
      {
        '<leader>sR',
        function()
          require('ssr').open()
        end,
        mode = { 'n', 'x' },
        desc = 'Structural Replace',
      },
    },
  },

  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = '+2' },
      },
    },
    keys = { { '<leader>z', '<cmd>ZenMode<cr>', desc = 'Zen Mode' } },
  },

  {
    'andymass/vim-matchup',
    event = 'BufReadPost',
    init = function()
      vim.o.matchpairs = '(:),{:},[:],<:>'
    end,
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = 'status_manual' }
    end,
  },
  -- better yank/paste
  {
    'gbprod/yanky.nvim',
    enabled = true,
    event = 'VeryLazy',
    dependencies = { { 'kkharji/sqlite.lua', enabled = not jit.os:find('Windows') } },
    opts = {
      highlight = { timer = 150 },
      ring = { storage = jit.os:find('Windows') and 'shada' or 'sqlite' },
    },
    keys = {
      -- stylua: ignore
      { "<leader>P", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Paste from Yanky" },
      { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' } },
      { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' } },
      { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' } },
      { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' } },
      { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' } },
      { '[y', '<Plug>(YankyCycleForward)' },
      { ']y', '<Plug>(YankyCycleBackward)' },
      { ']p', '<Plug>(YankyPutIndentAfterLinewise)' },
      { '[p', '<Plug>(YankyPutIndentBeforeLinewise)' },
      { ']P', '<Plug>(YankyPutIndentAfterLinewise)' },
      { '[P', '<Plug>(YankyPutIndentBeforeLinewise)' },
      { '>p', '<Plug>(YankyPutIndentAfterShiftRight)' },
      { '<p', '<Plug>(YankyPutIndentAfterShiftLeft)' },
      { '>P', '<Plug>(YankyPutIndentBeforeShiftRight)' },
      { '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)' },
      { '=p', '<Plug>(YankyPutAfterFilter)' },
      { '=P', '<Plug>(YankyPutBeforeFilter)' },
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
