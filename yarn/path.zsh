#!/bin/sh

# sup yarn
# https://yarnpkg.com

# shellcheck disable=SC2039,SC2154
if test "! $(which yarn)"; then
	# shellcheck disable=SC2155
	export PATH="$PATH:$(yarn global bin)"
fi
