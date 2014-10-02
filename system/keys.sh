#!/bin/bash
#

xcode-select --install

successfully() {
  $* || (echo "failed" 1>&2 && exit 1)
}

successfully !chsh -s /bin/zsh && sudo chsh -s /bin/zsh username

echo "Checking for SSH key, generating one if it doesn't exist ..."
  [[ -f ~/.ssh/id_rsa.pub ]] || ssh-keygen -t rsa

echo "Copying public key to clipboard. Paste it into your Github account ..."
  [[ -f ~/.ssh/id_rsa.pub ]] && cat ~/.ssh/id_rsa.pub | pbcopy
  successfully open https://github.com/account/ssh

echo "Fixing permissions ..."
  successfully sudo chown -R `whoami` /usr/local
