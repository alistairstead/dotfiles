-- packer.nvim configuration
local conf = {
  profile = {
    enable = true,
    threshold = 0.0001,
  },
  git = {
    -- clone_timeout = 300,
    -- subcommands = {
    --   update = 'pull --rebase',
    -- },
  },
  auto_clean = true,
  -- compile_on_sync = true,
  autoremove = true,
  max_jobs = 10,
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'solid' })
    end,
  },
  -- compile_path = vim.fn.stdpath('data') .. '/packer_compiled.lua',
}

local plugins = {


  -- Parenthesis highlighting
  ['p00f/nvim-ts-rainbow'] = { after = 'nvim-treesitter' },

  -- Autoclose tags
  ['windwp/nvim-ts-autotag'] = { after = 'nvim-treesitter' },


  -- Color highlighting
  ['NvChad/nvim-colorizer.lua'] = {
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('configs.colorizer')
    end,
  },


  -- Get extra JSON schemas
  ['b0o/SchemaStore.nvim'] = { module = 'schemastore' },

  -- Session manager
  -- ['Shatur/neovim-session-manager'] = {
  --   module = 'session_manager',
  --   cmd = 'SessionManager',
  --   event = 'BufWritePost',
  --   config = function()
  --     require('configs.session_manager')
  --   end,
  -- },
}

-- Plugins
-- local function plugins(use)


--   -- User interface

--   -- Search
--   use({ 'google/vim-searchindex', event = 'BufReadPre' })


--   -- Legendary
--   use({
--     'mrjones2014/legendary.nvim',
--     opt = true,
--     keys = { [[<C-p>]] },
--     -- wants = { "dressing.nvim" },
--     module = { 'legendary' },
--     cmd = { 'Legendary' },
--     config = function()
--       require('config.legendary').setup()
--     end,
--     -- requires = { "stevearc/dressing.nvim" },
--   })

--   -- Refactoring
--   use({
--     'ThePrimeagen/refactoring.nvim',
--     module = { 'refactoring', 'telescope' },
--     keys = { [[<leader>r]] },
--     wants = { 'telescope.nvim' },
--     config = function()
--       require('config.refactoring').setup()
--     end,
--   })
--   use({
--     'kevinhwang91/nvim-bqf',
--     ft = 'qf',
--     disable = true,
--     config = function()
--       require('bqf').setup()
--     end,
--     disable = true,
--   })
--   use({ 'nvim-pack/nvim-spectre', module = 'spectre', keys = { '<leader>s' } })
--   use({
--     'https://gitlab.com/yorickpeterse/nvim-pqf',
--     event = 'BufReadPre',
--     config = function()
--       require('pqf').setup()
--     end,
--     disable = true,
--   })
--   use({
--     'andrewferrier/debugprint.nvim',
--     module = { 'debugprint' },
--     keys = { 'g?p', 'g?P', 'g?v', 'g?V', 'g?o', 'g?O' },
--     cmd = { 'DeleteDebugPrints' },
--     config = function()
--       require('debugprint').setup()
--     end,
--     disable = true,
--   })
--   -- /IDE functionality



--   -- Jumps
--   use({
--     'ggandor/leap.nvim',
--     keys = { 's', 'S', 'f', 'F', 't', 'T' },
--     config = function()
--       local leap = require('leap')
--       leap.set_default_keymaps()
--     end,
--     disable = true,
--   })

--   -- Harpoon
--   use({
--     'ThePrimeagen/harpoon',
--     keys = { [[<leader>j]] },
--     module = { 'harpoon', 'harpoon.cmd-ui', 'harpoon.mark', 'harpoon.ui', 'harpoon.term' },
--     wants = { 'telescope.nvim' },
--     config = function()
--       require('config.harpoon').setup()
--     end,
--     disable = true,
--   })

--   -- Buffer
--   use({
--     'matbme/JABS.nvim',
--     cmd = 'JABSOpen',
--     config = function()
--       require('config.jabs').setup()
--     end,
--   })
--   use({
--     'chentoast/marks.nvim',
--     event = 'BufReadPre',
--     config = function()
--       require('marks').setup({})
--     end,
--   })

--   -- Automatic closing of code structures
--   -- Auto pairs
--   use({
--     'windwp/nvim-autopairs',
--     opt = true,
--     event = 'InsertEnter',
--     wants = 'nvim-treesitter',
--     module = { 'nvim-autopairs.completion.cmp', 'nvim-autopairs' },
--     config = function()
--       require('config.autopairs').setup()
--     end,
--   })

--   -- Auto tag
--   use({
--     'windwp/nvim-ts-autotag',
--     opt = true,
--     wants = 'nvim-treesitter',
--     event = 'InsertEnter',
--     config = function()
--       require('nvim-ts-autotag').setup({ enable = true })
--     end,
--   })

--   -- End wise
--   use({
--     'RRethy/nvim-treesitter-endwise',
--     opt = true,
--     wants = 'nvim-treesitter',
--     event = 'InsertEnter',
--   })

--   -- /Automatic closing of code structures


--   -- Quickfix
--   use({ 'romainl/vim-qf', event = 'BufReadPre', disable = true })

--   -- LSP
--   use({
--     'neovim/nvim-lspconfig',
--     opt = true,
--     event = { 'BufReadPre' },
--     wants = {
--       'mason.nvim',
--       'mason-lspconfig.nvim',
--       'mason-tool-installer.nvim',
--       'cmp-nvim-lsp',
--       'lua-dev.nvim',
--       'null-ls.nvim',
--       'schemastore.nvim',
--     },
--     config = function()
--       require('config.lsp').setup()
--     end,
--     requires = {
--       'williamboman/mason.nvim',
--       'williamboman/mason-lspconfig.nvim',
--       'neovim/nvim-lspconfig',
--       'WhoIsSethDaniel/mason-tool-installer.nvim',
--       'folke/lua-dev.nvim',
--       'jose-elias-alvarez/null-ls.nvim',
--       'b0o/schemastore.nvim',
--       {
--         'zbirenbaum/neodim',
--         event = 'LspAttach',
--         config = function()
--           require('config.neodim').setup()
--         end,
--       },
--     },
--   })

--   -- lspsaga.nvim
--   use({
--     'glepnir/lspsaga.nvim',
--     cmd = { 'Lspsaga' },
--     config = function()
--       require('lspsaga').init_lsp_saga()
--     end,
--   })

--   -- renamer.nvim
--   use({
--     'filipdutescu/renamer.nvim',
--     module = { 'renamer' },
--     config = function()
--       require('renamer').setup({})
--     end,
--   })

--   -- /LSP

--   -- Debugging
--   use({
--     'mfussenegger/nvim-dap',
--     opt = true,
--     -- event = "BufReadPre",
--     keys = { [[<leader>d]] },
--     module = { 'dap' },
--     wants = { 'nvim-dap-virtual-text', 'nvim-dap-ui', 'which-key.nvim' },
--     requires = {
--       'theHamsta/nvim-dap-virtual-text',
--       'rcarriga/nvim-dap-ui',
--       'nvim-telescope/telescope-dap.nvim',
--       { 'jbyuki/one-small-step-for-vimkind', module = 'osv' },
--     },
--     config = function()
--       require('config.dap').setup()
--     end,
--   })

--   -- Git
--   use({
--     'TimUntersberger/neogit',
--     cmd = 'Neogit',
--     config = function()
--       require('config.neogit').setup()
--     end,
--   })
--   use({
--     'lewis6991/gitsigns.nvim',
--     event = 'BufReadPre',
--     wants = 'plenary.nvim',
--     requires = { 'nvim-lua/plenary.nvim' },
--     config = function()
--       require('config.gitsigns').setup()
--     end,
--   })
--   use({
--     'ruifm/gitlinker.nvim',
--     requires = 'nvim-lua/plenary.nvim',
--     module = 'gitlinker',
--     config = function()
--       require('gitlinker').setup({ mappings = nil })
--     end,
--   })
--   use({
--     'akinsho/git-conflict.nvim',
--     cmd = {
--       'GitConflictChooseTheirs',
--       'GitConflictChooseOurs',
--       'GitConflictChooseBoth',
--       'GitConflictChooseNone',
--       'GitConflictNextConflict',
--       'GitConflictPrevConflict',
--       'GitConflictListQf',
--     },
--     config = function()
--       require('git-conflict').setup()
--     end,
--   })
--   use({
--     'knsh14/vim-github-link',
--     cmd = { 'GetCommitLink', 'GetCurrentBranchLink', 'GetCurrentCommitLink' },
--   })

--   -- Diffview
--   use({
--     'sindrets/diffview.nvim',
--     requires = 'nvim-lua/plenary.nvim',
--     cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles' },
--   })

--   -- Code screen shots
--   use({
--     'segeljakt/vim-silicon',
--     cmd = { 'Silicon' },
--   })

