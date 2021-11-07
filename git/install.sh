#!/bin/sh

if test $(which brew); then
	brew install git || brew upgrade git
	brew install diff-so-fancy || brew upgrade diff-so-fancy
	brew install hub || brew upgrade hub
fi

# Don't ask ssh password all the time
if [ "$(uname -s)" = "Darwin" ]; then
	git config --global credential.helper osxkeychain
else
	git config --global credential.helper cache
fi

git config --global core.excludesfile "${HOME}/.gitignore"

# better diffs
if test $(which diff-so-fancy); then
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
fi

# use ksdiff as mergetool
if test $(which ksdiff); then
	git config --global merge.tool Kaleidoscope
	git config --global mergetool.vscode.cmd "ksdiff --merge --output $MERGED --base $BASE -- $LOCAL --snapshot $REMOTE --snapshot"
fi
