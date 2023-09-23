#!/usr/bin/env sh

echo "Mac OS Install Setup Script"

sudo -v
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

unless ENV["CI"]
  echo "Installing xcode..."
  xcode-select --install
end

#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew); then
  echo "  Installing Homebrew for you."
  distro=$(uname)
  # Install the correct homebrew for each OS type
  if test "${distro}" = "Darwin"; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi

fi

brew upgrade
brew update

echo "Installing recipes from brew..."

brew install adr-tools
brew install ag
brew install awscli
brew install exa
brew install fd
brew install fzf
brew install gdu
brew install gh
brew install git
brew install jq
brew install ripgrep
brew install stow
brew install trash

echo "Installing GUI apps..."
unless ENV["CI"]
  brew tap homebrew/cask

  brew install bartender
  brew install choosy
  brew install cleanmymac
  brew install fantastical
  brew install figma
  brew install google-chrome
  brew install kap
  brew install kitty
  brew install nordvpn
  brew install orbstack
  brew install rocket


  brew tap 1password/tap
  brew install 1password-cli
end

echo "Brew clean up..."
brew cleanup

echo "Installing fonts..."
brew tap caskroom/fonts
brew install font-symbols-only-nerd-font

echo "Installing personal dotfiles..."
git clone https://github.com/alistairstead/dotfiles.git ~/dotfiles

cd dotfiles

echo ""
echo "Done!"

