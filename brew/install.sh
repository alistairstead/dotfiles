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


# GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
brew install moreutils
# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --default-names


# Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew install bash
# regular bash-completion package is held back to an older release, so we get latest from versions.
#   github.com/Homebrew/homebrew/blob/master/Library/Formula/bash-completion.rb#L3-L4
brew tap homebrew/versions
brew install homebrew/versions/bash-completion2

# generic colouriser  http://kassiopeia.juls.savba.sk/~garabik/software/grc/
brew install grc

# Install wget with IRI support
brew install wget --enable-iri

# Install more recent versions of some OS X tools
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/screen

# github util. imho better than hub
brew install gh
brew install hub


# mtr - ping & traceroute. best.
brew install mtr

# Install other useful binaries
brew install ack
brew install git
brew install git-extras
brew install imagemagick --with-webp
brew install node # This installs `npm` too using the recommended installation method
brew install pv
brew install rename
brew install tree
brew install zopfli
brew install ffmpeg --with-libvpx
brew install ssh-copy-id

brew install terminal-notifier

brew install android-platform-tools
brew install pidcat   # colored logcat guy

brew install zsh


brew tap homebrew/services

brew install heroku-toolbelt

# service
brew install mongodb
brew install rabbitmq
brew install redis

brew install trash

# PHP

brew tap homebrew/php
brew install homebrew/php/composer
brew install homebrew/php/php56

# Remove outdated versions from the cellar
brew cleanup
