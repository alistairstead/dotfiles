#!/usr/bin/env bash
#
# bootstrap installs things.

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

set -e

echo ''

info() {
	# shellcheck disable=SC2059
	printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user() {
	# shellcheck disable=SC2059
	printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success() {
	# shellcheck disable=SC2059
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail() {
	# shellcheck disable=SC2059
	printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
	echo ''
	exit
}

setup_gitconfig() {
	info 'setup gitconfig'
	# if there is no user.email, we'll assume it's a new machine/setup and ask it
	if [ -z "$(git config --global --get user.email)" ]; then
		user ' - What is your github author name?'
		read -r user_name
		user ' - What is your github author email?'
		read -r user_email

		git config --global user.name "$user_name"
		git config --global user.email "$user_email"
	elif [ "$(git config --global --get dotfiles.managed)" != "true" ]; then
		# if user.email exists, let's check for dotfiles.managed config. If it is
		# not true, we'll backup the gitconfig file and set previous user.email and
		# user.name in the new one
		user_name="$(git config --global --get user.name)"
		user_email="$(git config --global --get user.email)"
		mv ~/.gitconfig ~/.gitconfig.backup
		success "moved ~/.gitconfig to ~/.gitconfig.backup"
		git config --global user.name "$user_name"
		git config --global user.email "$user_email"
	else
		# otherwise this gitconfig was already made by the dotfiles
		info "already managed by dotfiles"
	fi

	if [ -z "$(git config --global --get github.user)" ]; then
		user ' - What is your github username?'
		read -r username
		git config --global github.user "$username"
	fi
	if [ -z "$(git config --global --get github.oauth-token)" ]; then
		user ' - What is your github oauth-token?'
		read -r token
		git config --global github.oauth-token "$token"
	fi
	# include the gitconfig.local file
	git config --global include.path ~/.gitconfig.local
	# finally make git knows this is a managed config already, preventing later
	# overrides by this script
	git config --global dotfiles.managed true

	info "Checking for SSH key, generating one if it doesn't exist ..."
	[ -f "${HOME}/.ssh/id_rsa.pub" ] || ssh-keygen -t rsa

	info "Copying public key to clipboard. Paste it into your Github account ..."
	if [ -f "${HOME}/.ssh/id_rsa.pub" ] && [ "$(uname -s)" = "Darwin" ]; then
		pbcopy <"${HOME}/.ssh/id_rsa.pub"
		open https://github.com/settings/keys
	fi


	success 'gitconfig intalled!'
}

setup_gitconfig
