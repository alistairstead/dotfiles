return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'


  -- UI
  use "dracula/vim"
  use {
    "folke/tokyonight.nvim"
  }
  use "ghifarit53/tokyonight-vim"

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('plugin-config.tree') end
  }
  use {
    'windwp/windline.nvim',
    config = function() require('plugin-config.windline') end
  }

  -- Syntaxes
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('plugin-config.treesitter') end
  }

  -- Language servers
  use {
    'williamboman/nvim-lsp-installer',
    config = function() require('plugin-config.lsp-installer') end
  }
  use {
    'neovim/nvim-lspconfig',
    requires = {{'hrsh7th/cmp-nvim-lsp'}},
    config = function() require('plugin-config.lspconfig') end
  }

  -- Completions
  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'dcampos/cmp-snippy'},
      {'hrsh7th/cmp-nvim-lua'},
      {'onsails/lspkind-nvim'},
    },
    config = function() require('plugin-config.cmp') end
  }
  use {
    "github/copilot.vim",
    config = function() require('plugin-config.copilot') end
  }

  -- Fuzzy finder for files and buffers
  use { 'nvim-telescope/telescope.nvim',
        requires = {
          {'nvim-lua/popup.nvim'},
          {'nvim-lua/plenary.nvim'},
          {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
          {'nvim-telescope/telescope-file-browser.nvim'},
        },
        config = function() require('plugin-config.telescope') end }

  -- Git visualisation
  use { 'tanvirtin/vgit.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('plugin-config.vgit') end }


  -- Formatter
  use {
    'mhartington/formatter.nvim',
    config = function() require('plugin-config.formatter') end
  }




end)
