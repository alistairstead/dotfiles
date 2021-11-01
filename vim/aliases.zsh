#!/bin/sh

vim() {
    if [ -s /usr/local/bin/nvim ]; then
      nvim "$@"
    else
      vim "$@"
    fi
}
