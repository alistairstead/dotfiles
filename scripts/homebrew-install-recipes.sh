#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/_functions.sh"

# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew recipes need Homebrew to install." && return 1

kegs=(
  homebrew/dupes
  homebrew/versions
  homebrew/command-not-found
  homebrew/completions
  homebrew/devel-only
)

brew_tap_kegs

# Homebrew recipes
recipes=(
  ack
  ag
  aspell --with-lang-en
  awk
  aws-shell
  awscli
  bash
  bash-completion2
  binutils
  chromedriver
  coreutils
  diffutils
  docker-completion
  docker-compose-completion
  docmacs
  editorconfig
  emacs --HEAD --use-git-head --with-cocoa --with-gnutls --with-rsvg --with-imagemagick
  fasd
  ffmpeg --with-libvpx --with-libvorbis --with-fdk-aacc
  findutils
  gh
  git
  git-extras
  gnu-sed --with-default-names
  gnu-tar --with-default-names
  gnu-which --with-default-names
  gnutls --with-default-names
  gpg
  grep
  gzip
  heroku-toolbelt
  htop
  hub
  kubernetes-cli
  launchctl-completion
  mackup
  mix-completion
  moreutils
  mtr
  neovim/neovim/neovim
  nmap
  nvm
  open-completion
  postgres
  rbenv
  ssh-copy-id
  terminal-notifier
  the_silver_searcher
  trash
  tree
  vim --override-system-vi
  watch
  wget --enable-iri
  zsh
)

brew_install_recipes

# Misc cleanup!

# This is wherejbrew stores its binary symlinks
local binroot="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

# bash
if [[ "$(type -P $binroot/zsh)" && "$(cat /etc/shells | grep -q "$binroot/zsh")" ]]; then
  e_header "Adding $binroot/zsh to the list of acceptable shells"
  echo "$binroot/zsh" | sudo tee -a /etc/shells >/dev/null
fi
if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/zsh" ]]; then
  e_header "Making $binroot/zsh your default shell"
  sudo chsh -s "$binroot/zsh" "$USER" >/dev/null 2>&1
  e_arrow "Please exit and restart all your shells."
fi
