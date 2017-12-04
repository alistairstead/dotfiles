#!/bin/sh

# init according to man page
# shellcheck disable=SC2039,2154
if (($+commands[rbenv])); then
  eval "$(rbenv init -)"
fi
