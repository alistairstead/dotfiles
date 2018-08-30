#!/usr/bin/env bash

set -ev

cd ~

git clone https://github.com/alistairstead/dotfiles .dotfiles

cd .dotfiles

./bin/dotfiles install
./bin/dotfiles symlinks
./bin/dotfiles gitconfig
./bin/dotfiles antibody
./bin/dotfiles brew
