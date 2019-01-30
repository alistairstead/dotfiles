#!/bin/sh

if which brew >/dev/null 2>&1; then
	brew() {
		case "$1" in
		cleanup)
			(cd "$(brew --repo)" && git prune && git gc)
			command brew cleanup
			command brew cask cleanup
			command brew cleanup
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
	me="$(whoami)"

	file1="$(stat /usr/local/bin | awk '{ print $5 }')"
	file2="$(stat /usr/local/share | awk '{ print $5 }')"

	if [ "$me" != "$file1" ]; then
		echo "Need to chown /usr/local/bin"
		sudo chown -R "$(whoami)":admin /usr/local/bin
	fi

	if [ "$me" != "$file2" ]; then
		echo "Need to chown /usr/local/share"
		sudo chown -R "$(whoami)":admin /usr/local/share
	fi

	brew doctor
	brew update
	brew upgrade
	brew cleanup
}
