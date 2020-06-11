#!/usr/bin/env bash

sudo -v
# Keep-alive: update existing `sudo` time stamp until install has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

cd ~
git clone https://github.com/alistairstead/dotfiles .dotfiles
cd .dotfiles
git pull

./src/bin/dotfiles symlinks
./src/bin/dotfiles install homebrew
./src/bin/dotfiles install
test -z "$CI" &&
	./src/bin/dotfiles gitconfig

./src/bin/dotfiles brew
./src/bin/dotfiles antibody
