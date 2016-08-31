# Make the $path array have unique values.
typeset -U path

function add_to_path_once() {
  path=("$1" $path)
}

gnu_utils_path='$(brew --prefix coreutils)/libexec/gnubin'
if [[ -f $gnu_utils_path ]]; then
  add_to_path_once $gnu_utils_path
fi
gnu_sed_path='$(brew --prefix gnu-sed)/libexec/gnubin'
if [[ -f $gnu_sed_path ]]; then
  add_to_path_once $gnu_sed_path
fi

add_to_path_once ~/dotfiles/bin
add_to_path_once ~/.composer/vendor/bin
add_to_path_once /usr/local/sbin
add_to_path_once ./bin

# Unset local functions
unset -f add_to_path_once
