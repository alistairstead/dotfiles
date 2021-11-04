#!/usr/local/env zsh

test -z "$CI" &&
  [ -f ~/.fzf.zsh ] && . ~/.fzf.zsh
