#!/bin/sh
if test ! $(which fzf); then
	if which brew >/dev/null 2>&1; then
		brew install fzf
		$(brew --prefix)/opt/fzf/install --all
	fi
fi
