#!/usr/local/env zsh

vim() {
    if [ -s /usr/local/bin/nvim ]; then
      nvim "$@"
    else
      vim "$@"
    fi
}
