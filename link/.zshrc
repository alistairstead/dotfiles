# $HOME/.zshrc
#

#Check if zplug is installed
if [[ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# load all files from dotfiles/zshrc.d directory
if [ -d ${ZDOTDIR:-$HOME}/dotfiles/zshrc.d ]; then
  for file in ${ZDOTDIR:-$HOME}/dotfiles/zshrc.d/*.zsh; do
    source $file
  done
fi

# load all files from dotfiles/rc.d directory
if [ -d ${ZDOTDIR:-$HOME}/dotfiles/rc.d ]; then
  for file in ${ZDOTDIR:-$HOME}/dotfiles/rc.d/*.sh; do
    source $file
  done
fi

if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
  . ~/.config/exercism/exercism_completion.zsh
fi
# The next line updates PATH for the Google Cloud SDK.
#source '/Users/astead/Dropbox/Mackup/Downloads/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
#source '/Users/astead/Dropbox/Mackup/Downloads/google-cloud-sdk/completion.zsh.inc'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
