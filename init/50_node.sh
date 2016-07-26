#!/usr/bin/env bash

# because I use a lazy loading strategy for nvm I need to source this file
# or the command check will fail witin the execution of install_dotfiles
source $DOTFILES/rc.d/functions.sh

# Confirm if a command exists
function _nvm_exists () {
    \command -v ${1} > /dev/null 2>&1 || {
      return 1;
    }
}

function install_nvm() {
  if ! _nvm_exists 'nvm'; then
    e_header 'Installing nvm...'
    curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
    e_header 'Reloading the shell'
    exec $SHELL -l && echo 'nvm installed!'
  else
    e_header 'nvm is already installed'
  fi
}

function install_node_stable() {
  nvm install stable
}

function install_node_global_packages() {
  npm install -g diff-so-fancy tern elm elm-test elm-oracle
}

install_nvm && install_node_stable && install_node_global_packages


