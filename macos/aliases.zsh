#!/bin/sh
# Some OS X-only stuff.
if [[ "$OSTYPE" == darwin* ]]; then
	# Short-cuts for copy-paste.
	alias c='pbcopy'
	alias p='pbpaste'

	# Remove all items safely, to Trash (`brew install trash`).
	if which trash >/dev/null 2>&1; then
		alias rm='trash'
	fi

	alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
	alias afk="open -a /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"

	# Lock current session and proceed to the login screen.
	alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

	# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
	alias stfu="osascript -e 'set volume output muted true'"
	alias pumpitup="osascript -e 'set volume 7'"

	# Clean up LaunchServices to remove duplicates in the “Open With” menu
	alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

	# Empty the Trash on all mounted volumes and the main HDD
	# Also, clear Apple’s System Logs to improve shell startup speed
	alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

	# Show/hide hidden files in Finder
	alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
	alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

	# Hide/show all desktop icons (useful when presenting)
	alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
	alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

fi
