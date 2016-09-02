# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew recipes need Homebrew to install." && return 1

kegs=(homebrew/versions)
brew_tap_kegs

# Homebrew recipes
recipes=(
  awk
  bash
  bash-completion2
  grc
  gpg
  keybase
  wget --enable-iri
  vim --override-system-vi
  neovim/neovim/neovim
  gh
  hub
  #mtr - ping & traceroute. best.
  mtr
  ack
  git
  git-extras
  tree
  ssh-copy-id
  zsh
  heroku-toolbelt
  trash
  python3
  findutils --default-names
  gnu-sed --default-names
  gnu-tar --default-names
  gnu-which --default-names
  gnutls --default-names
  grep --default-names
  coreutils
  moreutils
  binutils
  diffutils
  gzip
  watch
  tmux
  nmap
  htop
  selenium-server-standalone
  chromedriver
  jmeter
  mackup
  homebrew/binary/ngrok2
  reattach-to-user-namespace
  homebrew/devel-only/elm-format --HEAD
  jet
  Kubernetes-cli --HEAD
  terminal-notifier
)
IFS=$'\n'
brew_install_recipes
unset IFS

if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/zsh" ]]; then
  e_header "Making $binroot/zsh your default shell"
  sudo chsh -s "$binroot/zsh" "$USER" >/dev/null 2>&1
  e_arrow "Please exit and restart all your shells."
fi
