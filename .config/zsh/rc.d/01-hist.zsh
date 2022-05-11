#!/bin/zsh

##
# History settings
#
# Always set these first, so history is preserved, no matter what happens.
#

HIST_STAMPS="yyyy-mm-dd"

# Tell zsh where to store history.
# $VENDOR and $OSTYPE let us check what kind of machine we're on.
if [[ $VENDOR == apple ]]; then
  # On macOS, store it in iCloud, so it syncs across multiple Macs.
  HISTFILE=~/Library/Mobile\ Documents/com\~apple\~CloudDocs/zsh_history
else
  HISTFILE=${XDG_DATA_HOME:=~/.local/share}/zsh/history
fi

# Just in case: If the parent directory doesn't exist, create it.
[[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h

# Max number of entries to keep in history file.
SAVEHIST=$(( 100 * 1000 ))      # Use multiplication for readability.

# Max number of history entries to keep in memory.
HISTSIZE=$(( 1.2 * SAVEHIST ))  # Zsh recommended value

# Use modern file-locking mechanisms, for better safety & performance.
setopt HIST_FCNTL_LOCK

# Auto-sync history between concurrent sessions.
setopt SHARE_HISTORY

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

# Keep only the most recent copy of each duplicate entry in history.
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
