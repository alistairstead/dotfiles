function reload -d 'Reload the current shell and config'
  . $HOME/.config/fish/config.fish
  eval "$SHELL -l"
end
