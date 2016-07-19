# $HOME/.zshrc

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

export NVM_DIR="${HOME}/.nvm"
test -e "${NVM_DIR}/nvm.sh" && . "${NVM_DIR}/nvm.sh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
