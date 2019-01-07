#!/bin/sh

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# don't record dupes in history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST

setopt APPEND_HISTORY     # Allow multiple terminal sessions to all append to one zsh command history
setopt EXTENDED_HISTORY   # Include more information about when the command was executed, etc
setopt hist_ignore_dups   # Ignore duplication command history list
setopt hist_reduce_blanks # Remove extra blanks from each command line being added to history
setopt inc_append_history # Add comamnds as they are typed, don't wait until shell exit'
setopt hist_find_no_dups  # When searching history don't display results already cycled through twice'
setopt share_history      # Share command history data
setopt HIST_VERIFY
# share history between sessions ???
setopt SHARE_HISTORY
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# Shortcut for searching commands history.
# hist git
function hist() {
  history 0 | grep $@
}
