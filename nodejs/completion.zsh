#!/usr/local/env zsh

if test $(which npm); then
  source <(npm completion)
fi
