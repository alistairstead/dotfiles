#!/usr/local/env zsh

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
