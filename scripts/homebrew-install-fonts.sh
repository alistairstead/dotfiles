#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/_functions.sh"

# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew recipes need Homebrew to install." && return 1

# Tap Homebrew kegs.
function brew_tap_kegs() {
  if (( ${#kegs[@]} > 0 )); then
    e_header "Tapping Homebrew kegs: ${kegs[*]}"
    IFS=$'\n'
    for keg in "${kegs[@]}"; do
      brew tap $keg
    done
    unset IFS
  fi
}

# Install Homebrew recipes.
function brew_install_fonts() {
  if (( ${#fonts[@]} > 0 )); then
    e_header "Installing Homebrew fonts: ${fonts[*]}"
    IFS=$'\n'
    for font in "${fonts[@]}"; do
      e_header "Installing font: ${font}"
      brew caskjjj install $font
    done
    unset IFS
  fi
}


kegs=(
  caskroom/fonts
)

brew_tap_kegs

# Homebrew recipes
fonts=(
  font-anonymouspro-nerd-font-mono
  font-awesome-terminal-fonts
)

# Install Homebrew casks.
# casks=($(setdiff "${casks[*]}" "$(brew cask list 2>/dev/null)"))
if (( ${#fonts[@]} > 0 )); then
  e_header "Installing Homebrew fonts: ${casks[*]}"
  for font in "${fonts[@]}"; do
    brew cask install $font
  done
  brew cask cleanup
fi
