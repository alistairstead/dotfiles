setopt completealiases         # complete alisases
setopt extendedglob            # weird & wacky pattern matching - yay zsh!
setopt nolisttypes             # show types in completion
setopt autolist                # filename completion
setopt listpacked              # compact completion lists
setopt MARK_DIRS               # Append a trailing `/' to all directory names resulting from filename generation (globbing).
setopt completeinword          # not just at the end
setopt alwaystoend             # when complete from middle, move cursor

# Case sensitive, partial word and substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Formatting and messages
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
# Make zsh know about hosts already accessed by SSH
zstyle ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Speed up zsh completion
zstyle ':completion:*:paths' accept-exact '*(N)'
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Zsh auto rehash commands
zstyle ':completion:*' rehash true

# Case sensitive, partial word and substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Activate menu selection
zstyle ':completion:*' menu select=2

# Get zsh to color the completed part of the results when using tab completion.
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=34=36"

# I really like the kill|all autocomplete functionality of zsh.
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $(whoami) -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always
