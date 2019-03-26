#!/usr/bin/env bash

brew install elixir

mix local.hex --force

mix archive.install hex phx_new 1.4.2 --force
