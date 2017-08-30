#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/_functions.sh"

# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1


# Ensure the cask keg and recipe are installed.
kegs=(
  caskroom/versions
)

brew_tap_kegs

# Exit if Homebrew is not installed cask is now part of brew by default.
[[ ! "$(type -P brew)" ]] && e_error "Brew Cask recipes need Homebrew to install." && return 1

# Hack to show the first-run brew-cask password prompt immediately.
brew cask info this-is-somewhat-annoying 2>/dev/null

# Homebrew casks
casks=(
  # Applications
  ngrok
  alfred
  backblaze
  bartender
  cheatsheet
  chromium
  caffeine
  cloak
  cleanmymac
  dash
  docker
  dropbox
  duet
  evernote
  fantastical
  firefox
  google-chrome
  google-chrome-canary
  grammarly
  gyazo
  imagealpha
  imageoptim
  iterm2
  kaleidoscope
  kap
  keybase
  limechat
  miro-video-converter
  omnigraffle
  skype
  slack
  spectacle
  transmit
  transmission
  vlc
  webkit-nightly
)

# Install Homebrew casks.
# casks=($(setdiff "${casks[*]}" "$(brew cask list 2>/dev/null)"))
if (( ${#casks[@]} > 0 )); then
  e_header "Installing Homebrew casks: ${casks[*]}"
  for cask in "${casks[@]}"; do
    brew cask install $cask
  done
  brew cask cleanup
fi
