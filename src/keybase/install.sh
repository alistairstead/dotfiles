#!/bin/sh

# add the use-agent line to ~/.gnupg/gpg.conf
GPG_USE_AGENT=$(grep -e "#use-agent" ~/.gnupg/gpg.conf)
if [ "x$GPG_USE_AGENT" != "x" ]; then
	test -f ~/.gnupg/gpg.conf || mkdir ~/.gnupg
	echo "use-agent" >>~/.gnupg/gpg.conf
fi

if [ ! -f ~/.gnupg/gpg-agent.conf ]; then
	mkdir ~/.gnupg
	chmod 700 ~/.gnupg
	touch ~/.gnupg/gpg-agent.conf

	{
		echo "default-cache-ttl 3600"
		echo "max-cache-ttl 3600"
		echo "pinentry-program $(brew --prefix pinentry-mac)/bin/pinentry-mac"
	} > ~/.gnupg/gpg-agent.conf
fi

# gpg-agent
if test -n "$(pgrep gpg-agent)"; then
	true
else
	eval "$(gpg-agent --daemon)"
fi


test -z "$CI" &&
	keybase login
	KEYBASE_KEY_ID=$(keybase pgp list | sed -n -e 's/^.*ID:  //p')
	keybase pgp export -q "${KEYBASE_KEY_ID}" -o ~/keybase.public.key
	keybase pgp export -q "${KEYBASE_KEY_ID}" --secret -o ~/keybase.secret.key
	gpg --import ~/keybase.public.key
	gpg --import ~/keybase.secret.key

	# If you need to add your git email to your gpg
	#gpg --edit-key {username}@keybase.io
	# then adduid

	# Update the trust level to don't show warning messages
	# gpg --edit-key {username}@keybase.io trust quit

	# see https://github.com/pstadler/keybase-gpg-github

	git config --global user.signingkey "$(git config --get user.email)"
	git config --global commit.gpgsign true
	git config --global gpg.program "$(which gpg)"
	rm ~/keybase.public.key ~/keybase.secret.key
