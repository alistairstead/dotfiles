#!/usr/bin/env bash

if test $(which asdf); then
	asdf install elixir 1.10.3
	asdf global elixir 1.10.3
fi

if test $(which elixir); then
	mix local.hex --force
	mix local.rebar --force
	mix archive.install hex phx_new 1.5.1 --force
fi
