#!/bin/zsh

##
# Named directories
#
# Set these early, because it affects how dirs are displayed and printed.
#

# Create shortcuts for your favorite directories.
# `hash -d <name>=<path>` makes ~<name> a shortcut for <path>.
# You can use this ~name anywhere you would specify a dir, not just with `cd`!
hash -d z=$ZDOTDIR
hash -d g=$gitdir
hash -d d=$HOME/.dotfiles
hash -d c=$HOME/code


# Change dirs without `cd`. Just type the dir and press enter.
# NOTE: This will misfire if there is an alias, function, builtin or command
# with the same name!
# To be safe, use autocd only with paths starting with .. or / or ~ (including
# named directories).
setopt AUTO_CD
setopt PUSHD_TO_HOME
# push the old directory onto the stack on cd.
setopt AUTO_PUSHD
# do not store duplicates in the stack.
setopt PUSHD_IGNORE_DUPS
