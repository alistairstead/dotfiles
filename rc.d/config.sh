# rbenv
eval "$(rbenv init -)"

if brew command command-not-found-init > /dev/null 2>&1; then eval "$(brew command-not-found-init)"; fi

export PATH="/Users/alistairstead/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
