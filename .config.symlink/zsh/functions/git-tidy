#!/bin/sh
set -eu
# delete all local branches not on remote
git fetch -p && for branch in `git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'`; do git branch -D $branch; done
# delete tags not on remote
git fetch --prune origin '+refs/tags/*:refs/tags/*'
