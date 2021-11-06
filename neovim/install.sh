#!/bin/sh

if test $(which brew); then
	brew tap 'neovim/neovim'
	brew tap 'universal-ctags/universal-ctags'

	brew install neovim || brew upgrade neovim
	brew install ripgrep || brew upgrade ripgrep
	brew install --HEAD universal-ctags || brew upgrade universal-ctags
	brew install the_silver_searcher || brew upgrade the_silver_searcher
	brew install fd || brew upgrade fd
	brew install fzf || brew upgrade fzf
fi

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
