#!/usr/bin/env bash

# source ${PWD}/scripts/_functions.sh
source "${BASH_SOURCE%/*}/_functions.sh"

e_header "Installing node using nvm"

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

mkdir $HOME/.nvm

nvm install stable
nvm alias default stable

npm install -g yarn
yarn install -g diff-so-fancy tern nsp snyk elm elm-format elm-live elm-oracle

e_success "All global node packages installed."
