#!/bin/zsh

##
# Shell options that don't fit in any other file.
#
# Set these after sourcing plugins, because those might set options, too.
#

# Don't let > overwrite files. To overwrite, use >| instead.
setopt NO_CLOBBER

# Allow comments to be pasted into the command line.
setopt INTERACTIVE_COMMENTS

# Don't treat non-executable files in your $path as commands.
setopt HASH_EXECUTABLES_ONLY

# Enable additional glob operators. (Globbing = pattern matching)
# https://zsh.sourceforge.io/Doc/Release/Expansion.html#Filename-Generation
setopt EXTENDED_GLOB

# Enable ** and *** as shortcuts for **/* and ***/*, respectively.
# https://zsh.sourceforge.io/Doc/Release/Expansion.html#Recursive-Globbing
setopt GLOB_STAR_SHORT

# Sort numbers numerically, not lexicographically.
setopt NUMERIC_GLOB_SORT


# do not run all background jobs at a lower priority.
setopt NO_BG_NICE
# do not send the HUP signal to running jobs when the shell exits.
# allows background tasks to keep running when we close the shell.
setopt NO_HUP

# ensure parameter expansion, command substitution and arithmetic
# expansion are performed in prompts.
setopt PROMPT_SUBST
# do not beep on an ambiguous completion.
setopt NO_LIST_BEEP
# try to correct the spelling of commands.
setopt CORRECT
# do not exit on end-of-file.
# Require the use of exit or logout instead.
setopt IGNORE_EOF
