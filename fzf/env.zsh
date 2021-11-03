#!/usr/local/env zsh

# add support for ctrl+o to open selected file in the system editor
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(atom-beta {})+abort'"
export FZF_DEFAULT_COMMAND='rg --files --ignore --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
