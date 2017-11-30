#!/usr/bin/env bash

nvm install stable
nvm alias default stable

npm install -g yarn
yarn global add diff-so-fancy tern nsp snyk elm elm-format elm-live elm-oracle

if test ! $(which spoof)
then
    sudo npm install spoof -g
fi
