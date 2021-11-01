#!/usr/bin/env bash

set -e

if test ! $(which asdf); then
	brew install asdf

	asdf plugin-add erlang
	asdf plugin-add elixir
	asdf plugin-add nodejs
	asdf plugin-add ruby
	asdf plugin-add postgres
	asdf plugin-add php https://github.com/asdf-community/asdf-php.git


	brew install \
	  coreutils automake autoconf openssl \
	  libyaml readline libxslt libtool unixodbc \
	  unzip curl gpg

	bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
fi

echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
