#!/usr/bin/env bash

set -ev
sudo -v
cd ~
git clone https://github.com/alistairstead/dotfiles .dotfiles
cd .dotfiles

./bin/dotfiles symlinks
./bin/dotfiles install homebrew
./bin/dotfiles install
test -z "$CI" &&
	./bin/dotfiles gitconfig
./bin/dotfiles antibody
./bin/dotfiles brew

sudo xcodebuild -license accept