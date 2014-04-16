# Install command-line tools using Homebrew
# Usage: `brew bundle Brewfile`

# Make sure we’re using the latest Homebrew
update

# Upgrade any already-installed formulae
upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
install coreutils
# Install some other useful utilities like `sponge`
install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
install findutils
# Install Bash 4
install bash

# Install wget with IRI support
install wget --enable-iri


# Install more recent versions of some OS X tools
install vim --override-system-vi
install homebrew/dupes/grep
install josegonzalez/homebrew-php/php55
install josegonzalez/homebrew-php/php55-intl

# Install other useful binaries

install ack
install ant
install autoconf
install automake
install ctags
install fish
install gist
install git
install git-extras
install heroku-toolbelt
install hub
install hubflow
install imagemagick --with-webp
install mongodb
install node
install packer
install phantomjs
install pigz
install rbenv
install redis
install rename
install ruby-build
install ssh-copy-id
install tmux
install tree


# Remove outdated versions from the cellar
cleanup
