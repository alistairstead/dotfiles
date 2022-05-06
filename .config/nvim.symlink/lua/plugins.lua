return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Syntaxes

  use 'leafgarland/typescript-vim'
  use { 'peitalin/vim-jsx-typescript', config = function() require('plugin-config.jsx-syntax') end }
  use { 'pangloss/vim-javascript', ft = {'javascript'} }
  use { 'elixir-editors/vim-elixir', ft = {'elixir'} }

  -- Spacing
  use 'editorconfig/editorconfig-vim'


  -- Change quotes and parentheses
  use 'tpope/vim-commentary'
  use 'tpope/vim-sensible'
  use 'tpope/vim-surround'
  use 'tpope/vim-abolish'


end)
