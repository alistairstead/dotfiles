#!/bin/sh

# Some OS X-only stuff.
if [[ "$OSTYPE" == darwin* ]]; then

  # Trim new lines and copy to clipboard
  alias c="tr -d '\n' | pbcopy"
	alias p='pbpaste'

	# Remove all items safely, to Trash (`brew install trash`).
	if which trash >/dev/null 2>&1; then
		alias rm='trash'
	fi

  # Recursively delete `.DS_Store` files
  alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

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

  # Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
  alias update='sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update'

  # Flush Directory Service cache
  alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

  # Merge PDF files
  # Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
  alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

  # Disable Spotlight
  alias spotoff="sudo mdutil -a -i off"
  # Enable Spotlight
  alias spoton="sudo mdutil -a -i on"

  # PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
  alias plistbuddy="/usr/libexec/PlistBuddy"


  # Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
  # (useful when executing time-consuming commands)
  alias badge="tput bel"

  # Canonical hex dump; some systems have this symlinked
  command -v hd > /dev/null || alias hd="hexdump -C"

  # OS X has no `md5sum`, so use `md5` as a fallback
  command -v md5sum > /dev/null || alias md5sum="md5"

  # OS X has no `sha1sum`, so use `shasum` as a fallback
  command -v sha1sum > /dev/null || alias sha1sum="shasum"

  alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
fi
