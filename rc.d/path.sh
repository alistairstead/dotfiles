gnu_path='$(brew --prefix coreutils)/libexec/gnubin'
if [[ -f $gnu_path ]]; then
  export PATH=$gnu_path:$PATH
fi
export PATH=~/dotfiles/bin:$PATH
export PATH=~/.composer/vendor/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="./bin:$PATH"
