#!/usr/local/env zsh

if [[ ${SHELL} != *"zsh"* ]]; then
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
else
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi
