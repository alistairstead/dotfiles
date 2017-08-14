# Make the $path array have unique values.
typeset -U path

function add_to_path_once() {
  path=("$1" $path)
}

add_to_path_once ~/dotfiles/bin
add_to_path_once ~/.composer/vendor/bin
add_to_path_once /usr/local/sbin
add_to_path_once /usr/local/bin
add_to_path_once ./bin
add_to_path_once $HOME/.fastlane/bin
# Unset local functions
unset -f add_to_path_once
