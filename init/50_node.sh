# /usr/bin/env bash

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

mkdir $HOME/.nvm

nvm install stable
nvm alias default stable

npm install -g diff-so-fancy tern nsp snyk elm elm-format elm-live elm-oracle



