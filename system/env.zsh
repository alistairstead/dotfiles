#!/bin/sh

export TERM='screen-256color'
export TERM_PROGRAM='iTerm.app'

# Always enable colored `grep` output.
export GREP_OPTIONS='--color=auto'

# add support for ctrl+o to open selected file in the system editor
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(atom-beta {})+abort'"
