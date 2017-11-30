export XDG_CONFIG_HOME=$HOME/.config
# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

export TERM='screen-256color'
export TERM_PROGRAM='iTerm.app'

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export PORT=8080
export NODE_ENV=development
export DEBUG=express:*
# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY_FILE=~/.node_history
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768'
export NVM_DIR="$HOME/.nvm"

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768'
export HISTFILESIZE="${HISTSIZE}"
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth'

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}"

# Always enable colored `grep` output.
export GREP_OPTIONS='--color=auto'

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
