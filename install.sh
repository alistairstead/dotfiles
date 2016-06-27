#!/usr/bin/env bash

cd ~
chsh -s $(which zsh)
git clone https://github.com/alistairstead/dotfiles
cd ~/dotfiles
git submodule update --init --recursive
install/bootstrap.sh
