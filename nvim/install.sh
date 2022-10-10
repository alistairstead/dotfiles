#!/bin/sh

if test $(which brew); then
    brew tap 'neovim/neovim'

    brew install --HEAD neovim || brew reinstall --HEAD neovim
    brew install fzf || brew upgrade fzf
fi

