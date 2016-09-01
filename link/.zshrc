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
if [ -d $HOME/dotfiles/zshrc.d ]; then
  for file in $HOME/dotfiles/zshrc.d/*.zsh; do
    source $file
  done
fi

# load all files from dotfiles/rc.d directory
if [ -d $HOME/dotfiles/rc.d ]; then
  for file in $HOME/dotfiles/rc.d/*.sh; do
    source $file
  done
fi

# The next line updates PATH for the Google Cloud SDK.
source '/Users/astead/Dropbox/Mackup/Downloads/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/astead/Dropbox/Mackup/Downloads/google-cloud-sdk/completion.zsh.inc'
