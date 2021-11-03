#!/usr/local/env zsh

# the cursor stays where it was and completion is done from both ends.
setopt COMPLETE_IN_WORD
# if a completion is performed with the cursor within a word, and a
# full completion is inserted, the cursor is moved to the end of the
# word. That is, the cursor is moved to the end of the word if either
# a single match is inserted or menu completion is performed.
setopt ALWAYS_TO_END
# Prevents aliases on the command line from being internally
# substituted before completion is attempted.
setopt COMPLETE_ALIASES
# treat the '#', '~' and '^' characters as part of patterns for
# filename generation, etc.
setopt EXTENDED_GLOB
# do not show the type of each file with a trailing identifying mark.
setopt NO_LIST_TYPES
# automatically list choices on an ambiguous completion.
setopt AUTO_LIST
# try to make the completion list smaller (occupying less lines) by
# printing the matches in columns with different widths.
setopt LIST_PACKED
# append a trailing '/' to all directory names resulting from
# filename generation (globbing).
setopt MARK_DIRS

# case sensitive, partial word and substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending
# zsh auto rehash commands
zstyle ':completion:*' rehash true
# case sensitive, partial word and substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# activate menu selection
zstyle ':completion:*' menu select=2
# get zsh to color the completed part of the results when using tab completion.
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=34=36"

# speed up zsh completion
zstyle ':completion:*:paths' accept-exact '*(N)'
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# completion formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'%{\e[0;33m%} %B%d%b%{\e[0m%}'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*:default' list-prompt'%S%M matches%s'
zstyle ':completion:*:prefix:*' add-space true
# I really like the kill|all autocomplete functionality of zsh.
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $(whoami) -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always
