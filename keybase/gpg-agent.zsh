#!/bin/sh

# gpg-agent
if test -n "$(pgrep gpg-agent)"; then
	true
else
	eval "$(gpg-agent --daemon)"
fi
