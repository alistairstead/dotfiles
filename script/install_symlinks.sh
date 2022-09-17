#!/usr/bin/env bash

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

link_file() {
	local src=$1 dst=$2

	local overwrite backup skip
	local action

	if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then

		if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then

			local currentSrc="$(readlink $dst)"

			if [ "$currentSrc" == "$src" ]; then

				skip=true

			else

				user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
				read -n 1 action

				case "$action" in
				o)
					overwrite=true
					;;
				O)
					overwrite_all=true
					;;
				b)
					backup=true
					;;
				B)
					backup_all=true
					;;
				s)
					skip=true
					;;
				S)
					skip_all=true
					;;
				*) ;;

				esac

			fi

		fi

		overwrite=${overwrite:-$overwrite_all}
		backup=${backup:-$backup_all}
		skip=${skip:-$skip_all}

		if [ "$overwrite" == "true" ]; then
			rm -rf "$dst"
			success "removed $dst"
		fi

		if [ "$backup" == "true" ]; then
			mv "$dst" "${dst}.backup"
			success "moved $dst to ${dst}.backup"
		fi

		if [ "$skip" == "true" ]; then
			success "skipped $src"
		fi
	fi

	if [ "$skip" != "true" ]; then
		ln -s "$1" "$2"
		success "linked $1 to $2"
	fi
}

link_symlinks() {
	info 'creating links to managed files'

	local overwrite_all=false backup_all=false skip_all=false

    # create folders for deep symlinks
    mkdir -p "$HOME/.config/nvim"
    mkdir -p "$HOME/.ssh"

	for src in $(find -H "$DOTFILES_ROOT" -name '*.symlink' -not -path '*.git/*'); do
		dstPath="${src#$DOTFILES_ROOT/}"
		dst="$HOME/${dstPath%.*}"
		# echo "linking $src to $dst"
		link_file "$src" "$dst"
	done
}

find_zsh() {
	if which zsh >/dev/null 2>&1 && grep "$(which zsh)" /etc/shells >/dev/null; then
		which zsh
	else
		echo "/bin/zsh"
	fi
}

link_symlinks

zsh="$(find_zsh)"

test -z "$CI" &&
	which chsh >/dev/null 2>&1 &&
	chsh -s "$zsh" &&
	success "set $("$zsh" --version) at $zsh as default shell"

echo ''
echo '  All installed!'