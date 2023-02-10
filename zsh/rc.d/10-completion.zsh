#!/bin/zsh

autoload -U compinit
compinit -i

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

# Real-time auto-completion
# znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-completions
znap source Aloxaf/fzf-tab

complete -C '/opt/homebrew/bin/aws_completer' aws

eval "$(op completion zsh)"; compdef _op op

if [ ! -f /opt/homebrew/share/zsh/site-functions/_gh ]; then
  gh completion -s zsh > /opt/homebrew/share/zsh/site-functions/_gh
fi

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
