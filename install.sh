#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master
function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE-MIT.txt" -av --no-perms . ~
	source ~/.bash_profile
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt


curl https://raw.github.com/Alex7Kom/nvm-fish/master/install.fish | fish

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

which brew || {
echo "Installing Homebrew, a good OS X package manager ..."
  successfully ruby <(curl -fsS https://raw.github.com/mxcl/homebrew/go)
}
