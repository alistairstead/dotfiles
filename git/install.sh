#!/bin/sh

successfully() {
	"$*" || (echo "failed" 1>&2 && exit 1)
}

echo "Checking for SSH key, generating one if it doesn't exist ..."
[ -f "${HOME}/.ssh/id_rsa.pub" ] || ssh-keygen -t rsa

echo "Copying public key to clipboard. Paste it into your Github account ..."
[ -f "${HOME}/.ssh/id_rsa.pub" ] cat ${HOME}/.ssh/id_rsa.pub | pbcopy
successfully open https://github.com/account/ssh


# Don't ask ssh password all the time
if [ "$(uname -s)" = "Darwin" ]; then
	git config --global credential.helper osxkeychain
else
	git config --global credential.helper cache
fi

git config --global core.excludesfile "${HOME}/.gitignore-global"

# better diffs
if which diff-so-fancy >/dev/null 2>&1; then
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
fi

# use ksdiff as mergetool
if which ksdiff >/dev/null 2>&1; then
	git config --global merge.tool Kaleidoscope
	git config --global mergetool.vscode.cmd "ksdiff --merge --output $MERGED --base $BASE -- $LOCAL --snapshot $REMOTE --snapshot"
fi
