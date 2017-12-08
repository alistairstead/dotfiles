#!/bin/sh

if test ! $(which antibody); then
	if which brew >/dev/null 2>&1; then
		brew install getantibody/tap/antibody || brew upgrade antibody
	else
		curl -sL https://git.io/antibody | sh -s
	fi
fi
