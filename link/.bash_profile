if [ -f $HOME/.bashrc ]; then
  source $HOME/.bashrc
fi

# load all files from dotfiles/login.d directory
if [ -d $HOME/dotfiles/login.d ]; then
  for file in $HOME/dotfiles/login.d/*.sh; do
    source $file
  done
fi
