#!/usr/bin/env sh

echo "Mac OS Install Setup Script"

sudo -v
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

unless ENV["CI"]
  echo "Installing xcode..."
  xcode-select --install
end

#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew); then
  echo "  Installing Homebrew for you."
  distro=$(uname)
  # Install the correct homebrew for each OS type
  if test "${distro}" = "Darwin"; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi

fi

brew upgrade
brew update

echo "Installing recipes from brew..."

brew install adr-tools
brew install ag
brew install awscli
brew install coreutils
brew install curl
# https://direnv.net
brew install direnv
brew install exa
brew install fd
brew install fzf
brew install gdu
brew install gh
brew install git
brew install git-delta
brew install gnu-sed
brew install gum
brew install jq
brew install yq

brew tap neovim/neovim
brew install --HEAD neovim
brew install fzf

brew install ripgrep
brew install joshmedeski/sesh/sesh
brew install ssh-copy-id
brew install starship
brew install stow
brew install trash
brew install yabai
brew install zoxide

if test ! ENV["CI"]; then
  echo "Installing GUI apps..."

  brew tap homebrew/cask

  brew install bartender
  brew install choosy
  brew install cleanmymac
  brew install fantastical
  brew install figma
  brew install google-chrome
  brew install hammerspoon
  brew install kap
  brew install nordvpn
  brew install orbstack
  brew install rocket
  brew install wezterm

  # Install op cli
  brew tap 1password/tap
  brew install 1password-cli
fi

echo "Brew clean up..."
brew cleanup

echo "Installing fonts..."
brew tap homebrew/cask-fonts
brew install font-symbols-only-nerd-font

echo "Installing personal dotfiles..."
git clone git@github.com:alistairstead/dotfiles.git ~/dotfiles

cd ~/dotfiles


echo "Creating symlinks..."

stow asdf bin gh git kitty nvim ssh starship tmux wezterm yabai zsh

echo "Install zap..."

zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

if test ! $(which asdf); then
  echo "Installing asdf..."
  # Documentation: https://asdf-vm.com
  # brew install asdf
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1

  asdf plugin-add erlang
  asdf plugin-add elixir
  asdf plugin-add nodejs
  asdf plugin-add pnpm
  asdf plugin-add postgres
  asdf plugin-add php https://github.com/asdf-community/asdf-php.git
  asdf plugin-add direnv

  brew install \
    coreutils automake autoconf openssl \
    libyaml readline libxslt libtool unixodbc \
    unzip curl gpg

  bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
fi

test -f ~/.ssh/config.local || touch ~/.ssh/config.local

if test $(which brew); then
	brew install diff-so-fancy || brew upgrade diff-so-fancy
fi

if [ "$(uname -s)" = "Darwin" ]; then
  echo "Configuring git for mac-os settings..."
  # Don't ask ssh password all the time
  git config --global credential.helper osxkeychain
  # 1Password commit signing
  if test ! ENV["CI"]; then
    git config --global user.signingkey $(op item get 'SSH Key' --fields label='public key')
    git config --global gpg.format "ssh"
    git config --global gpg.ssh.program "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    git config --global commit.gpgsign true
  fi
else
  echo "Configuring git for linux..."
  # Don't ask ssh password all the time
  git config --global credential.helper cache
fi

git config --global core.excludesfile "${HOME}/.config/.gitignore"
git config --global include.path "${HOME}/.config/.gitconfig"

# better diffs
if test $(which diff-so-fancy); then
  git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
fi

if test "${distro}" = "Darwin"; then
  echo "Configuring mac-os settings..."
  bash ./script/mac-settings.sh
fi

echo "Configuring tmux plugins..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

echo "Done!"

