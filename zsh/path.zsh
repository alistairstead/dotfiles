# Add composer packages to my path

gnu_path='$(brew --prefix coreutils)/libexec/gnubin'
if [[ -f $gnu_path ]]; then
  export PATH=$gnu_path:$PATH
fi
export PATH=~/src/dotfiles/bin:$PATH
export PATH=~/.composer/vendor/bin:$PATH
