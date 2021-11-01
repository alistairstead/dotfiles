#!/usr/bin/env bash

sudo -v
# Keep-alive: update existing `sudo` time stamp until install has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

cd ~
git clone https://github.com/alistairstead/dotfiles .dotfiles
cd .dotfiles
git pull

./bin/dotfiles symlinks
./bin/dotfiles install homebrew

./bin/dotfiles brew

./bin/dotfiles install antibody
./bin/dotfiles install asdf
./bin/dotfiles install docker
./bin/dotfiles install elixir
./bin/dotfiles install fzf
./bin/dotfiles install git
test -z "$CI" &&
	./bin/dotfiles gitconfig


git remote set-url origin git@github.com:alistairstead/dotfiles.git
