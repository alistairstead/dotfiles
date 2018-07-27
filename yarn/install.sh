#!/usr/bin/env bash

packages=(diff-so-fancy tern nsp snyk elm elm-format \
						elm-live elm-oracle elm-test \
						prettier prettier-plugin-elm husky)

for package in "${packages[@]}"; do
	if test ! $(which "${package}"); then
		yarn global add "${package}"
	fi
done
