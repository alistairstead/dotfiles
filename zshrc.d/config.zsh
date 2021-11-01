#!/bin/sh

fpath=($DOTFILES/functions $fpath)

autoload -U "$DOTFILES"/functions/*(:t)

# change to dirs without cd
setopt autocd
# push to home directory when no argument is given.
setopt pushd_to_home
# push the old directory onto the stack on cd.
setopt auto_pushd
# do not store duplicates in the stack.
setopt pushd_ignore_dups

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





# keybindings
bindkey '^f' forward-word
bindkey '^b' backward-word

# Last command timer if command took longer than 5 seconds
function preexec() { timer=${timer:-$SECONDS} }
function precmd() {
        if [ $timer ]; then
                timer_show=$(($SECONDS - $timer))
                unset timer
                if [ $timer_show -ge 5 ]; then
                        print -rP '%BTook ${timer_show}s%f'
                fi
        fi
}
