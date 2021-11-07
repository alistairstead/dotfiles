#!/bin/sh

if test $(which brew); then
    brew install ssh-copy-id || brew upgrade ssh-copy-id
fi

test -d ~/.ssh || mkdir ~/.ssh
test -f ~/.ssh/config.local || touch ~/.ssh/config.local
