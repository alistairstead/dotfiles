-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup({ function(use)
  -- Packer
  use({ 'wbthomason/packer.nvim' })

  -- Performance
  use({ 'dstein64/vim-startuptime', cmd = 'StartupTime' })
  use({
    'nathom/filetype.nvim',
    config = function()
      vim.g.did_load_filetype = 1
    end,
  })
  -- /Performance

  -- general UI improvements
  use({
    'levouh/tint.nvim',
    -- "lewis6991/hover.nvim",
    'luukvbaal/stabilize.nvim',
    { 'kevinhwang91/nvim-bqf', ft = 'qf', requires = {
      'junegunn/fzf',
    } },
  })

  -- Icons
  use({
    'kyazdani42/nvim-web-devicons',
    -- event = 'VimEnter',
  })

  -- trouble.nvim
  use({
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    config = function()
      require('trouble').setup({
        use_diagnostic_signs = true,
      })
    end,
  })

  -- Bufferline
  use({
    'akinsho/bufferline.nvim',
  })

  -- Status line
  use({
    'nvim-lualine/lualine.nvim',
    requires = {
      'SmiteshP/nvim-navic',
    },
  })

  use({
    'glepnir/dashboard-nvim',
  })

  -- Better Commenting
  use({
    'numToStr/Comment.nvim',
    requires = {
      { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' },
    },
  })
  -- tpope
  use({
    'tpope/vim-repeat',
    'tpope/vim-surround',
    'tpope/vim-fugitive',
    'tpope/vim-sleuth',
  })

  -- Primeagen doesn"t create lodash
  use('ThePrimeagen/git-worktree.nvim')
  use('ThePrimeagen/harpoon')
  use('ThePrimeagen/refactoring.nvim')

  -- Better buffer closing
  use({
    'moll/vim-bbye',
  })

  -- Cloak (by laytanl_)
  use('laytan/cloak.nvim')

  use('s1n7ax/nvim-window-picker')

  -- File explorer
  use({
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    module = 'neo-tree',
    cmd = 'Neotree',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      { 'MunifTanjim/nui.nvim', module = 'nui' },
    },
    setup = function()
      vim.g.neo_tree_remove_legacy_commands = true
    end,
  })

  -- Syntax highlighting
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'windwp/nvim-ts-autotag',
    },
  })

  -- Better indentation
  use({
    'editorconfig/editorconfig-vim',
    setup = function()
      vim.g.EditorConfig_max_line_indicator = ''
      vim.g.EditorConfig_preserve_formatoptions = 1
    end,
  })

  -- AI completion
  -- use('github/copilot.vim')
  use('zbirenbaum/copilot.lua')
  use({
    'zbirenbaum/copilot-cmp',
    after = { 'copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
    end,
  })

  -- Terminal
  use({
    'akinsho/toggleterm.nvim',
    module = { 'toggleterm', 'toggleterm.terminal' },
  })

  -- Telescope
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
      },
      'nvim-telescope/telescope-project.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'ahmedkhalf/project.nvim',
    },
  })

  -- Language servers
  use { 'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'lukas-reineke/lsp-format.nvim' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'davidsierradz/cmp-conventionalcommits' },
      { 'petertriho/cmp-git' },
      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
      -- UI
      { 'zbirenbaum/neodim' },
      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim' },

      -- Additional lua configuration, makes nvim stuff amazing
      { 'folke/neodev.nvim' },
    }
  }

  -- Colorscheme
  use({
    'folke/tokyonight.nvim',
    'projekt0n/github-nvim-theme',
    'navarasu/onedark.nvim',
  })

  -- Colours
  use({
    'NvChad/nvim-colorizer.lua',
  })

  -- Markdown
  use({
    'lukas-reineke/headlines.nvim',
    config = function()
      require('headlines').setup()
    end,
  })

  -- Git
  use({
    'lewis6991/gitsigns.nvim',
    {
      'TimUntersberger/neogit',
      requires = {
        'nvim-lua/plenary.nvim',
      },
    },
  })

  use({
    'nvim-neotest/neotest',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-plenary',
      'marilari88/neotest-vitest',
      'nvim-neotest/neotest-vim-test',
      'vim-test/vim-test',
    },
  })

end,
  config = {
    max_jobs = 10,
    profile = {
      enable = true,
      threshold = 0.0001,
    },
    -- auto_clean = true,
    -- compile_on_sync = true,
    -- autoremove = true,
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'none' })
      end,
    },
  }
})

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this file
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = 'plugins.lua',
})
