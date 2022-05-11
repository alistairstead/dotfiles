#!/bin/zsh

##
# Environment variables
#

# your project folder that we can `t [tab]` to
export PROJECTS="$HOME/github"

# export EDITOR=/usr/local/bin/code
export EDITOR='code -w -r'
# export GIT_EDITOR='vim'

export NODE_ENV=development
# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY_FILE=~/.node_history
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768'

# add support for ctrl+o to open selected file in the system editor
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(atom-beta {})+abort'"
export FZF_DEFAULT_COMMAND='rg --files --ignore --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

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

export KERL_CONFIGURE_OPTIONS="--disable-debug --disable-silent-rules --without-javac --enable-shared-zlib --enable-dynamic-ssl-lib --enable-hipe --enable-sctp --enable-smp-support --enable-threads --enable-kernel-poll --enable-wx --enable-darwin-64bit --with-ssl=/usr/local/opt/openssl"


# -U ensures each entry in these is Unique (that is, discards duplicates).
export -U PATH path FPATH fpath MANPATH manpath
export -UT INFOPATH infopath  # -T creates a "tied" pair; see below.

# $PATH and $path (and also $FPATH and $fpath, etc.) are "tied" to each other.
# Modifying one will also modify the other.
# Note that each value in an array is expanded separately. Thus, we can use ~
# for $HOME in each $path entry.
path=(
    ~/.dotfiles/bin
    ./node_modules/.bin
    /opt/local/{,s}bin(N) # MacPorts
    /opt/homebrew/{,s}bin(N) # Homebrew
    ~/.local/bin
    $path[@]
)

# Add your functions to your $fpath, so you can autoload them.
fpath=(
    $ZDOTDIR/functions
    $fpath[@]
)

if command -v brew > /dev/null; then
  # `znap eval <name> '<command>'` is like `eval "$( <command> )"` but with
  # caching and compilation of <command>'s output, making it 10 times faster.
  znap eval brew-shellenv 'brew shellenv'

  # Add dirs containing completion functions to your $fpath and they will be
  # picked up automatically when the completion is initialized.
  # Here, we add it to the end of $fpath, so that we use brew's completions
  # only for those commands that zsh doesn't already know how to complete.
  fpath+=( /opt/homebrew/share/zsh/site-functions )
fi
