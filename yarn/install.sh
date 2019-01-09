packages=(tern nsp snyk elm elm-format \
						elm-live elm-oracle elm-test \
						prettier prettier-plugin-elm husky bash-language-server)

<<<<<<< Updated upstream
if test $(which yarn); then
	for package in "${packages[@]}"; do
		if test ! $(which "${package}"); then
			yarn global add "${package}"
		fi
	done
fi
=======
packages=(diff-so-fancy tern nsp snyk elm elm-format elm-live elm-oracle elm-test prettier)

for package in "${packages[@]}"; do
	if test ! $(which "${package}"); then
		yarn global add "${package}"
	fi
done
>>>>>>> Stashed changes
