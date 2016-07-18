# Use neovim as default editor if available
if which nvim &> /dev/null; then
  export EDITOR=nvim
# Fallback to vim
elif which vim &> /dev/null; then
  export EDITOR=vim
fi
