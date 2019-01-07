packages=(tern nsp snyk elm elm-format \
						elm-live elm-oracle elm-test \
						prettier prettier-plugin-elm husky)

if test $(which yarn); then
	for package in "${packages[@]}"; do
		if test ! $(which "${package}"); then
			yarn global add "${package}"
		fi
	done
fi
