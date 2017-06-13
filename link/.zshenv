# Prefer UK English and use UTF-8

export LC_ALL="en_GB.UTF-8"
export LANG='en_GB.UTF-8'
export LC_CTYPE='en_GB.UTF-8'

# disable control flow so that ctrl-s can be used in vim
stty -ixon
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
