#!/bin/sh


cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

set -e

echo 'Starting install of antibody'

# Run antibody to install and cache source
run_install_antibody() {
	antibody bundle <"${DOTFILES_ROOT}/antibody/bundles.txt" >~/.zsh_plugins.sh
	antibody update
}


if test ! $(which antibody); then
	if which brew >/dev/null 2>&1; then
		brew install getantibody/tap/antibody || brew upgrade antibody
	else
		curl -sL https://git.io/antibody | sh -s
	fi

	run_install_antibody
fi


echo 'Completed install of antibody'
