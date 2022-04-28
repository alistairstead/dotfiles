return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Motion
    use {
      'phaazon/hop.nvim',
      branch = 'v1', -- optional but strongly recommended
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        require('plugin-config.hop')
      end
    }


-- Devicons
  use 'kyazdani42/nvim-web-devicons'

  -- Syntaxes

  use 'leafgarland/typescript-vim'
  use { 'peitalin/vim-jsx-typescript', config = function() require('plugin-config.jsx-syntax') end }
  use { 'pangloss/vim-javascript', ft = {'javascript'} }
  use { 'elixir-editors/vim-elixir', ft = {'elixir'} }

  -- Spacing
  use 'editorconfig/editorconfig-vim'

  -- UNIX operations
  use { 'tpope/vim-eunuch', config = function() require('plugin-config.eunuch') end }

  -- Exchange two pieces of text
  use 'tommcdo/vim-exchange'

  -- Change quotes and parentheses
  use 'tpope/vim-commentary'
  use 'tpope/vim-sensible'
  use 'tpope/vim-surround'
  use 'tpope/vim-abolish'

  -- Expand vim movement objects to support comma and tag attributes
  use 'austintaylor/vim-commaobject'
  use { 'whatyouhide/vim-textobj-xmlattr', requires = {{'kana/vim-textobj-user'}} }

  -- Fuzzy finder for files and buffers
  use { 'nvim-telescope/telescope.nvim',
        requires = {
          {'nvim-lua/popup.nvim'},
          {'nvim-lua/plenary.nvim'},
          {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
        },
        config = function() require('plugin-config.telescope') end }

  -- Snippets
  use { 'dcampos/nvim-snippy',
        config = function() require('plugin-config.snippy') end }

  -- Autocompletion
  use { 'hrsh7th/nvim-cmp',
        requires = {
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-path'},
          {'dcampos/cmp-snippy'},
          {'hrsh7th/cmp-nvim-lua'},
          {'onsails/lspkind-nvim'},
        },
        config = function() require('plugin-config.cmp') end }

  -- Language servers
  use { 'neovim/nvim-lspconfig',
        requires = {{'hrsh7th/cmp-nvim-lsp'}},
        config = function() require('plugin-config.lspconfig') end }

  -- Formatter
  use { 'mhartington/formatter.nvim',
        config = function() require('plugin-config.formatter') end }

  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'

  use 'machakann/vim-highlightedyank'

end)
