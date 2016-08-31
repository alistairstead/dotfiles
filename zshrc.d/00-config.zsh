#if [[ -n $SSH_CONNECTION ]]; then
#  export PS1='%m:%3~$(git_info_for_prompt)%# '
#else
#  export PS1='%3~$(git_info_for_prompt)%# '
#fi

export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

setopt nobeep                  # i hate beeps
setopt autopushd               # automatically append dirs to the push/pop list
setopt cdablevars              # avoid the need for an explicit $
setopt correct_all             # correct all the words in the command line
setopt noflowcontrol           # if I could disable Ctrl-s completely I would!
setopt RM_STAR_WAIT            # confirmation after 'rm *' etc..

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps

setopt PROMPT_SUBST
setopt CORRECT
setopt IGNORE_EOF

bindkey '^?' backward-delete-char
bindkey "^P" history-substring-search-up
bindkey "^N" history-substring-search-down
bindkey "^R" history-incremental-search-backward
bindkey "^L" forward-word
bindkey "^H" backward-word
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# bind UP and DOWN arrow keys for history search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down


setopt autocd                   # change to dirs without cd
setopt pushd_to_home            # Push to home directory when no argument is given.
setopt auto_pushd               # Push the old directory onto the stack on cd.
setopt auto_name_dirs           # Auto add variable-stored paths to ~ list.
setopt pushd_ignore_dups        # Do not store duplicates in the stack.

# Report CPU usage for commands running longer than 10 seconds.
export TIMEFMT="%U user %S system %P cpu %*E total, running %J"
REPORTTIME=10

#ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

## Aliases and functions
#ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'
#ZSH_HIGHLIGHT_STYLES[function]='fg=cyan,bold'

## Commands and builtins
#ZSH_HIGHLIGHT_STYLES[command]="fg=green"
#ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=green,bold"
#ZSH_HIGHLIGHT_STYLES[builtin]="fg=green,bold"
#ZSH_HIGHLIGHT_STYLES[precommand]="fg=green,underline"
#ZSH_HIGHLIGHT_STYLES[commandseparator]="none"

## Paths
#ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'

## Globbing
#ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow,bold'

## Options and arguments
#ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=red'
#ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=red'

#ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=green"
#ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=green"
#ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=green"
#ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=green"
#ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=green"

## Patterns
#ZSH_HIGHLIGHT_PATTERNS+=('mv *' 'fg=white,bold,bg=red')
#ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
#ZSH_HIGHLIGHT_PATTERNS+=('sudo ' 'fg=white,bold,bg=red')
