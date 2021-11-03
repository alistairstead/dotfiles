#!/usr/local/env zsh

export TERM='screen-256color'
export TERM_PROGRAM='iTerm.app'
export CLICOLOR=true
export CLICOLOR_FORCE=true

# congirue LS colors (generated with https://geoff.greer.fm/lscolors/)
export LSCOLORS='ExGxBxDxCxEgEdxbxgxcxd'
export LS_COLORS='di=1;34:ln=1;36:so=1;31:pi=1;33:ex=1;32:bd=1;34;46:cd=1;34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43'

# encoding
# Prefer UK English and use UTF-8
export LC_ALL="en_GB.UTF-8"
export LANG='en_GB.UTF-8'
export LC_CTYPE='en_GB.UTF-8'

# Always enable colored `grep` output.
export GREP_OPTIONS='--color=auto'

# GPG
export GPG_TTY=$(tty)
