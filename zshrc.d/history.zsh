#!/usr/local/env zsh

# history size
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# whenever the user enters a line with history expansion, don't
# execute the line directly; instead, perform history expansion and
# reload the line into the editing buffer.
setopt HIST_VERIFY

# when searching history don't display results already cycled through
# twice.
setopt HIST_FIND_NO_DUPS

# allow multiple terminal sessions to all append to one zsh command history
setopt APPEND_HISTORY
# include more information about when the command was executed, etc
setopt EXTENDED_HISTORY
# add comamnds as they are typed, don't wait until shell exit'
setopt INC_APPEND_HISTORY
# Share command history data
setopt SHARE_HISTORY

# don't record dupes in history
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# Shortcut for searching commands history.
# hist git
function hist() {
  history 0 | grep $@
}
