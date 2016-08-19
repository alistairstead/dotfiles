# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Ensure the cask keg and recipe are installed.
kegs=(caskroom/versions)
brew_tap_kegs
recipes=(brew-cask)
brew_install_recipes

# Exit if, for some reason, cask is not installed.
[[ ! "$(brew ls --versions brew-cask)" ]] && e_error "Brew-cask failed to install." && return 1

# Hack to show the first-run brew-cask password prompt immediately.
brew cask info this-is-somewhat-annoying 2>/dev/null

# Homebrew casks
casks=(
  # Applications
  alfred
  atom-beta
  backblaze
  bartender
  cheatsheet
  chromium
  cloak
  cleanmymac
  dash
  docker
  dropbox
  duet
  evernote
  fantastical
  firefox-nightly
  firefox
  gitter
  google-chrome
  google-chrome-canary
  gyazo
  imagealpha
  imageoptim
  iterm2
  java
  kaleidoscope
  licecap
  limechat
  little-snitch
  miro-video-converter
  omnifocus-beta
  omnifocus-clip-o-tron
  omnigraffle
  skype
  slack
  spectacle
  transmit
  transmission
  vlc
  webkit-nightly
  #Collection of Quicklook extensions
  animated-gif-quicklook
  qlimagesize
  betterzipql
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-csv
  quicklook-json
  quicknfo
  suspicious-package
  webpquicklook
)

# Install Homebrew casks.
casks=($(setdiff "${casks[*]}" "$(brew cask list 2>/dev/null)"))
if (( ${#casks[@]} > 0 )); then
  e_header "Installing Homebrew casks: ${casks[*]}"
  for cask in "${casks[@]}"; do
    brew cask install $cask
  done
  brew cask cleanup
fi
