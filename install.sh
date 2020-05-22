#!/usr/bin/env bash

sudo -v
# Keep-alive: update existing `sudo` time stamp until install has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

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
