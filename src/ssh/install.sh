#!/bin/sh
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"

test -d ~/.ssh || mkdir ~/.ssh
test -f ~/.ssh/config || {
	mv ~/.ssh/config ~/.ssh/config.local
}
test -L ~/.ssh/config || ln -s "$DOTFILES_DIR"/ssh/config ~/.ssh/config
test -f ~/.ssh/config.local || touch ~/.ssh/config.local
