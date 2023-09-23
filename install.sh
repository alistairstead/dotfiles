#!/usr/bin/env sh

echo "Mac OS Install Setup Script"

sudo -v
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

echo "Installing xcode..."
xcode-select --install

echo "Installing brew..."
if test ! $(which brew); then
	## Don't prompt for confirmation when installing homebrew
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
fi

brew upgrade
brew update
brew tap caskroom/cask

echo "Installing recipes from brew..."
