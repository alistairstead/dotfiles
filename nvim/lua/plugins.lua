local PACKER_BOOTSTRAP = false

-- packer.nvim configuration
local conf = {
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

-- Check if packer.nvim is installed
-- Run PackerCompile if there are changes in this file
local function packer_init()
  local fn = vim.fn
  -- Automatically install packer
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    })
    print('Installing packer close and reopen Neovim...')
    vim.cmd([[packadd packer.nvim]])
  end

  -- Autocommand that reloads neovim whenever you save the plugins.lua file
  local packer_grp = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
  vim.api.nvim_create_autocmd(
    { "BufWritePost" },
    { pattern = "plugins.lua", command = "source <afile> | PackerSync", group = packer_grp }
  )
end

-- Plugins
local function plugins(use)
  -- Plugin manager
  use({ 'wbthomason/packer.nvim' })
  -- Optimiser
  use({ 'lewis6991/impatient.nvim' })
  -- Performance
  use({
    'max397574/better-escape.nvim',
    event = 'InsertCharPre',
  })
  use({
    'antoinemadec/FixCursorHold.nvim',
    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  })
  use({ 'dstein64/vim-startuptime', cmd = 'StartupTime' })
  use({
    'nathom/filetype.nvim',
    config = function()
      vim.g.did_load_filetype = 1
    end,
  })
  -- /Performance

  -- Lua functions
  use { "nvim-lua/plenary.nvim", module = "plenary" }

  -- Popup API
  use('nvim-lua/popup.nvim')


  use({
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  })

  -- Neovim UI Enhancer
  use({
    'stevearc/dressing.nvim',
    -- event = 'VimEnter',
  })

  -- Smooth scrolling
  use({
    'declancm/cinnamon.nvim',
    -- event = { 'BufRead', 'BufNewFile' },
  })

  -- general UI improvements
  use({
      {
        "airblade/vim-rooter",
        config = function()
          vim.g.rooter_patterns = {'.git', 'Makefile'}
        end,
      },
      "levouh/tint.nvim",
      -- "lewis6991/hover.nvim",
      "luukvbaal/stabilize.nvim",
      { "kevinhwang91/nvim-bqf", ft = "qf", requires = {
          "junegunn/fzf",
      } },
  })

  -- Smarter Splits
  use({
    'mrjones2014/smart-splits.nvim',
    module = 'smart-splits',
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
    'feline-nvim/feline.nvim',
    disable = true,
  })

  use({
    'nvim-lualine/lualine.nvim',
    -- disable = true,
  })

  -- Start screen
  use({
    'goolord/alpha-nvim',
    cmd = 'Alpha',
    module = 'alpha',
    disable = true,
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
  use {
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "tpope/vim-fugitive",
    -- "tpope/vim-unimpaired",
    {
        "tpope/vim-sleuth",
        setup = function()
            vim.g.sleuth_automatic = 0
        end,
    },
    {
        "tpope/vim-dispatch",
        requires = { "radenling/vim-dispatch-neovim" },
    },
  }

  -- Better buffer closing
  use({
    'famiu/bufdelete.nvim',
    -- cmd = { 'Bdelete', 'Bwipeout' },
  })

  use({
    's1n7ax/nvim-window-picker',
    tag = 'v1.*',
    module = 'window-picker',
  })

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
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
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
  use({
    'github/copilot.vim',
    setup = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ''
    end,
  })

  -- Terminal
  use({
    'akinsho/toggleterm.nvim',
    module = { 'toggleterm', 'toggleterm.terminal' },
  })

  -- Completion
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'ray-x/cmp-treesitter',
      'saadparwaiz1/cmp_luasnip',
      'davidsierradz/cmp-conventionalcommits',
      "petertriho/cmp-git",
      'onsails/lspkind-nvim',
      'windwp/nvim-autopairs',
      {
        'L3MON4D3/LuaSnip',
        requires = { "rafamadriz/friendly-snippets" },
      },
    },
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
      "nvim-telescope/telescope-project.nvim",
    },
  })

  -- Built-in LSP
  use({
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'lukas-reineke/lsp-format.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'jose-elias-alvarez/typescript.nvim',
      'neovim/nvim-lspconfig',
      'folke/lua-dev.nvim',
      'stevearc/aerial.nvim',
      'b0o/SchemaStore.nvim',
      'ray-x/lsp_signature.nvim',
      'jayp0521/mason-null-ls.nvim',
      'jose-elias-alvarez/typescript.nvim',
      'lvimuser/lsp-inlayhints.nvim',
      'glepnir/lspsaga.nvim',
      'SmiteshP/nvim-navic',
      "zbirenbaum/neodim",
      'onsails/lspkind.nvim',
    },
  })

  -- Colorscheme
  use({
    'folke/tokyonight.nvim',
    'projekt0n/github-nvim-theme',
  })

  -- Colours
  use {
    "NvChad/nvim-colorizer.lua",
  }

  use({
    'AndrewRadev/splitjoin.vim',
    keys = { 'gS', 'gJ' },
  })

  -- Markdown
  use {
    "lukas-reineke/headlines.nvim",
  }

  -- Git
  use ({
    -- "rhysd/git-messenger.vim",
    "ruifm/gitlinker.nvim",
    'lewis6991/gitsigns.nvim',
    { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  })

  use({
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-plenary",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-vim-test",
      "vim-test/vim-test",
    },
  })

  -- Bootstrap Neovim
  if PACKER_BOOTSTRAP then
    print('Neovim restart is required after installation!')
    require('packer').sync()
  end
end

-- Init and start packer
packer_init()
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Performance
local impatient_ok, impatient = pcall(require, 'impatient')
if impatient_ok then
  impatient.enable_profile()
end
-- pcall(require, "packer_compiled")

packer.init(conf)
packer.startup(plugins)
