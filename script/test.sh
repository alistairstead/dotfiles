#!/usr/bin/env bash

set -e

if [ ! -z "$TRAVIS_JOB_ID" ]; then
  exit 0
fi

# link to ~ and cd to it
cd ..
cp -rf dotfiles ~/.dotfiles
cd ~/.dotfiles

# bootstrap the mighty
./bin/dotfiles install
./bin/dotfiles symlinks
./bin/dotfiles gitconfig
./bin/dotfiles antibody
./bin/dotfiles update

# load zshrc and check if antibody is working
# shellcheck disable=SC1090
source ~/.zshrc

test "$(antibody list | wc -l)" -gt 8 || {
  echo "expecting 8+ bundles loaded" >&2
  exit 1
}

test -s ~/.zcompdump || {
  echo "zcompdump file is empty" >&2
  exit 1
}

# check if a random plugin is working (meaning that the bundles were loaded)
nvm
