#!/bin/sh

test -d ~/.ssh || mkdir ~/.ssh
test -f ~/.ssh/config.local || touch ~/.ssh/config.local
