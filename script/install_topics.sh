#!/usr/bin/env bash

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

set -e

echo ''


# Run all dotfiles installers.
run_install_files() {
	# find the installers and run them iteratively
	for file in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name 'install.sh' -not -path '*.git*')
	do
		installer="${file}"
		echo "› ${installer}..."
		bash "$installer"
	done
}

run_install_files
