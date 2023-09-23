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

brew tap neovim/neovim
brew install --HEAD neovim || brew reinstall --HEAD neovim
brew install fzf || brew upgrade fzf

brew install ripgrep
brew install stow
brew install trash

if test ! ENV["CI"]; then
  echo "Installing GUI apps..."

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

  # Install op cli
  brew tap 1password/tap
  brew install 1password-cli
fi

echo "Brew clean up..."
brew cleanup

echo "Installing fonts..."
brew tap homebrew/cask-fonts
brew install font-symbols-only-nerd-font

echo "Install zap..."
# zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

echo "Installing personal dotfiles..."
git clone https://github.com/alistairstead/dotfiles.git ~/dotfiles

cd ~/dotfiles


echo "Creating symlinks..."

stow kitty nvim

echo "Done!"

