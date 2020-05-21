#!/usr/bin/env bash
if test $(which asdf); then
	asdf install nodejs 14.3.0
	asdf global nodejs 14.3.0
fi

packages=(tern nsp snyk elm elm-format \
						elm-live elm-oracle elm-test \
						prettier prettier-plugin-elm bash-language-server)

if test $(which npm); then
	for package in "${packages[@]}"; do
		if test ! $(which "${package}"); then
			npm install -g "${package}"
		fi
	done
fi
