#!/bin/sh

if which brew >/dev/null 2>&1; then
  brew() {
    case "$1" in
    cleanup)
      (cd "$(brew --repo)" && git prune && git gc)
      rm -rf "$(brew --cache)"
      ;;
    bump)
      command brew update
      command brew upgrade
      brew cleanup
      ;;
    *)
      command brew "$@"
      ;;
    esac
  }
fi

alias brwe=brew

# Freshen up your brew.
freshbrew() {
  brew bump
  brew cleanup
  brew doctor
}
