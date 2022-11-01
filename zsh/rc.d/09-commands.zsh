#!/bin/zsh

##
# Commands, funtions and aliases
#
# Always set aliases _last,_ so they don't class with function definitions.
#


# These aliases enable us to paste example code into the terminal without the
# shell complaining about the pasted prompt symbol.
alias %= \$=

alias cp='cp -v'
alias mv='mv -v'
alias ln='ln -v'
alias rm='rm -v'

alias tn='tmux new -s ${PWD##*/}'
alias ta='tmux at -t'
alias tls='tmux list-sessions'

# zmv lets you batch rename (or copy or link) files by using pattern matching.
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#index-zmv
autoload -Uz zmv
alias zmv='zmv -Mv'
alias zcp='zmv -Cv'
alias zln='zmv -Lv'

# Note that, unlike Bash, there's no need to inform Zsh's completion system
# of your aliases. It will figure them out automatically.


# Set $PAGER if it hasn't been set yet. We need it below.
# `:` is a builtin command that does nothing. We use it here to stop Zsh from
# evaluating the value of our $expansion as a command.
: ${PAGER:=less}


# Associate file .extensions with programs.
# This lets you open a file just by typing its name and pressing enter.
# Note that the dot is implicit. So, `gz` below stands for files ending in .gz
alias -s {css,gradle,html,js,json,md,patch,properties,txt,xml,yml}=$PAGER
alias -s gz='gzip -l'
alias -s {log,out}='tail -F'


# Use `< file` to quickly view the contents of any file.
READNULLCMD=$PAGER  # Set the program to use for this.

# modern make
if which mmake >/dev/null 2>&2; then
	alias make='mmake'
fi

# exa is a better ls tool
if which exa >/dev/null 2>&1; then
	alias ls='exa'
	alias l='exa -la --git'
	alias la='exa -laa --git'
	alias ll='exa -l --git'
else
	if [ "$(uname -s)" = "Darwin" ]; then
		alias ls="ls -FG"
	else
		alias ls="ls -F --color"
	fi
	alias l="ls -lAh"
	alias la="ls -A"
	alias ll="ls -l"
fi

alias grep="grep --color=auto"
alias duf="du -sh * | sort -hr"
alias less="less -r"

# quick hack to make watch work with aliases
alias watch='watch '

# open, pbcopy and pbpaste on linux
if [ "$(uname -s)" != "Darwin" ]; then
	if [ -z "$(command -v pbcopy)" ]; then
		if [ -n "$(command -v xclip)" ]; then
			alias pbcopy="xclip -selection clipboard"
			alias pbpaste="xclip -selection clipboard -o"
		elif [ -n "$(command -v xsel)" ]; then
			alias pbcopy="xsel --clipboard --input"
			alias pbpaste="xsel --clipboard --output"
		fi
	fi
	if [ -e /usr/bin/xdg-open ]; then
		alias open="xdg-open"
	fi
fi

if test $(which brew); then
  brew() {
    case "$1" in
    cleanup)
      (cd "$(brew --repo)" && git prune && git gc)
      rm -rf "$(brew --cache)"
      ;;
    bump)
      command brew update
      command brew upgrade
      brew cleanup
      ;;
    *)
      command brew "$@"
      ;;
    esac
  }
fi

alias brwe=brew

# Freshen up your brew.
freshbrew() {
  brew bump
  brew cleanup
  brew doctor
}

alias ga='git add'
alias gs='git status -sb'

alias push='git push'
alias pull='git pull'

gi() {
	curl -s "https://www.gitignore.io/api/$*"
}

g() {
	args=$@
	if [[ $# -eq 0 ]]; then
		git status --short
	else
		git $args
	fi
}

gc() {
	args=$@
	if [[ $# -eq 0 ]]; then
		git commit -v
	else
		git commit -m "$args"
	fi
}

alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

alias cat='bat'
alias ping='prettyping --nolegend'
# alias preview="fzf --preview 'bat --color \"always\" {}'"
alias preview="fzf --height 40% --preview 'if file -i {}|grep -q binary; then file -b {}; else bat --color \"always\" --line-range :40 {}; fi'"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

alias top="sudo htop" # alias top and fix high sierra bug

alias hosts='sudo $EDITOR /etc/hosts' # yes I occasionally 127.0.0.1 twitter.com ;)

# alias divers
alias services='sudo netstat -tulpn'

# Create a data URL from a file
function dataurl() {
	mimeType=$(file -b --mime-type "$1")
	# shellcheck disable=SC2039
	if [[ "$mimeType" == text/* ]]; then
		mimeType="${mimeType};charset=utf-8"
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Opens file in EDITOR.
function edit() {
  local dir=$1
  [[ -z "$dir" ]] && dir='.'
  $EDITOR $dir
}
alias e=edit

# Enable aliases to be sudo’ed
# alias sudo='sudo '

# Get week number
alias week='date +%V'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

alias vim="nvim"

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