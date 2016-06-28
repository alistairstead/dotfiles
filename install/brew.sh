#!/usr/bin/env bash

# Confirm if a command exists
function command_exists () {
    \command -v ${1} > /dev/null 2>&1 || {
      return 1;
    }
}

function _get_brew() {
  if ! command_exists 'brew'; then
    echo 'Installing brew...'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap homebrew/bundle
  fi
}

function init() {
  _get_brew;
}

init

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

brew tap homebrew/versions

brew install bash
brew install bash-completion2
brew install grc
brew install gpg
brew install keybase
brew install wget --enable-iri
brew install vim --override-system-vi
brew install gh
brew install hub
# mtr - ping & traceroute. best.
brew install mtr
brew install ack
brew install git
brew install git-extras
brew install tree
brew install ssh-copy-id
brew install zsh
brew install heroku-toolbelt
brew install trash

brew install findutils --default-names
brew install gnu-sed --default-names
brew install gnu-tar --default-names
brew install gnu-which --default-names
brew install gnutls --default-names
brew install grep --default-names
brew install coreutils
brew install moreutils
brew install binutils
brew install diffutils
brew install gzip
brew install watch
brew install tmux
brew install nmap
brew install htop
brew install selenium-server-standalone
brew install chromedriver
brew install jmeter
brew install mackup

# Remove outdated versions from the cellar
brew cleanup
