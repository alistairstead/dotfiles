#!/bin/sh


cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

set -e

echo 'Starting install of antibody'

# Run antibody to install and cache source
run_install_antibody() {
	rm ~/.zsh_plugins.sh
	antibody bundle <"${DOTFILES_ROOT}/antibody/bundles.txt" >~/.zsh_plugins.sh
	antibody update
}


if test ! $(which antibody); then
	if test $(which brew); then
	    brew tap getantibody/tap
		brew install antibody || brew upgrade antibody
	else
		curl -sL https://git.io/antibody | sh -s
	fi

fi

run_install_antibody

echo 'Completed install of antibody'
