#!/usr/bin/env bash

cd ~
git clone https://github.com/alistairstead/dotfiles
cd ~/.zprezto
git submodule update --init --recursive
cd ~/dotfiles
git submodule update --init --recursive
./bin/install_dotfiles
