mkdir $HOME/.config

ln -s $HOME/.vim $HOME/.config/nvim
ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim

pip3  install --upgrade neovim

nvim -c ":PlugInstall"
nvim -c ":UpdateRemotePlugins"
