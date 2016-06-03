#!/usr/bin/env bash

# Confirm if a command exists
function command_exists () {
    \command -v ${1} > /dev/null 2>&1 || {
      return 1;
    }
}

function _get_nvm() {
  if ! command_exists 'nvm'; then
    echo 'Installing nvm...'
    curl https://raw.githubusercontent.com/creationix/nvm/v0.25.1/install.sh | bash
  fi
}

function init() {
  _get_nvm;
}

init
