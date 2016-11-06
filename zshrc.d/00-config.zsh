export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

setopt RM_STAR_WAIT            # confirmation after 'rm *' etc..

bindkey '^?' backward-delete-char
bindkey "^L" forward-word
bindkey "^H" backward-word
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line


# Report CPU usage for commands running longer than 10 seconds.
export TIMEFMT="%U user %S system %P cpu %*E total, running %J"
REPORTTIME=10

if brew command command-not-found-init > /dev/null 2>&1; then eval "$(brew command-not-found-init)"; fi
