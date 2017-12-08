#!/usr/bin/env bash

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

set -e

echo ''


# Run antibody to install and cache source
run_install_antibody() {
	antibody bundle <"$DOTFILES/antibody/bundles.txt" >~/.zsh_plugins.sh
	antibody update
}

run_install_antibody
