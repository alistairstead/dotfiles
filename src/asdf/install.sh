#!/usr/bin/env bash

set -e

if test ! $(which asdf); then
	brew install asdf

	asdf plugin-add erlang
	asdf plugin-add elixir
	asdf plugin-add nodejs
	asdf plugin-add ruby
	asdf plugin-add postgres

	brew install \
	  coreutils automake autoconf openssl \
	  libyaml readline libxslt libtool unixodbc \
	  unzip curl gpg
fi
