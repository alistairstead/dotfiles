#!/usr/bin/env bash

# because I use a lazy loading strategy for nvm I need to source this file
# or the command check will fail witin the execution of install_dotfiles
source $DOTFILES/rc.d/functions.sh

mkdir $HOME/.nvm

nvm install stable

npm install -g diff-so-fancy tern nsp snyk elm elm-format elm-oracle



