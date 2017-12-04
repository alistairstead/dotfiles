#!/usr/bin/env bash

export PORT=8080
export NODE_ENV=development
export DEBUG="express:*"
# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY_FILE=~/.node_history
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768'
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1090
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm
