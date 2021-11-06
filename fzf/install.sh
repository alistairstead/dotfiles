#!/bin/sh

if test ! $(which fzf); then
	if test $(which brew); then
		brew install fzf || brew upgrade fzf
		$(brew --prefix fzf)/install --all
	fi
fi
