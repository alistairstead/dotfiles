# $HOME/.bashrc
#
# this file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output. so make sure this doesn't display
# anything or bad things will happen !

# test for an interactive shell. there is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # shell is non-interactive. be done now!
  return
fi

# load all files from dotfiles/bashrc.d directory
if [ -d $HOME/dotfiles/bashrc.d ]; then
  for file in $HOME/dotfiles/bashrc.d/*.bash; do
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
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
