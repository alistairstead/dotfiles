#!/bin/zsh
#
# This file, .zshrc, is sourced by zsh for each interactive shell session.
#
# Note: For historical reasons, there are other dotfiles, besides .zshenv and
# .zshrc, that zsh reads, but there is really no need to use those.

# The construct below is what Zsh calls an anonymous function; most other
# languages would call this a lambda or scope function. It gets called right
# away with the arguments provided and is then discarded.
# Here, it enables us to use scoped variables in our dotfiles.
# () {
#   # Load all of the files in rc.d that start with <number>- and end in .zsh
#   # (n) sorts the results in numerical order.
#   # <-> is an open-ended range. It matches any non-negative integer.
#   # <1-> matches any integer >= 1. <-9> matches any integer <= 9.
#   # <1-9> matches any integer that's >= 1 and <= 9.
#   local file=
#   for file in $HOME/rc.d/<->-*.zsh(n); do
#     source $file
#   done
# } "$@"
# $@ expands to all the arguments that were passed to the current context (in
# this case, to `zsh` itself).
# "Double quotes" ensures that empty arguments '' are preserved.
# It's a good practice to pass "$@" by default. You'd be surprised at all the
# bugs you avoid this way.
#
# Created by Zap installer https://www.zapzsh.org
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "marlonrichert/zsh-edit" # Better keyboard shortcuts
plug "marlonrichert/zsh-hist" # Edit history from the command line.
plug "zsh-users/zsh-autosuggestions" # Inline suggestions
plug "zsh-users/zsh-syntax-highlighting" # Command-line syntax highlighting
plug "zsh-users/zsh-history-substring-search" # History search
plug "zap-zsh/supercharge"
plug "zap-zsh/exa"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "reegnz/jq-zsh-plugin"

alias vim="nvim"
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.config/nvim"
alias tmuxrc="vim ~/.tmux.conf"

alias pn=pnpm
alias code="cd ~/code"
alias dotfiles="cd ~/dotfiles"

# Remove all items safely, to Trash (`brew install trash`).
if which trash >/dev/null 2>&1; then
  alias rm='trash'
fi

alias ga='git add'
alias gs='git status -sb'
alias gco='git co'


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


alias cb='git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff --color=always {1} " --pointer="" | xargs git checkout'

function ghpr() {
  GH_FORCE_TTY=100% gh pr list | fzf --query "$1" --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout -f
}
function ghgist() {
  GH_FORCE_TTY=100% gh gist list --limit 20 | fzf --ansi --preview 'GH_FORCE_TTY=100% gh gist view {1}' --preview-window down | awk '{print $1}' | xargs gh gist edit
}

source "$HOME/.asdf/asdf.sh"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -r ~/private/.zshrc ] && source ~/private/.zshrc

# initialise completions with ZSH's compinit
autoload -Uz compinit
compinit

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(direnv hook zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/Users/alistairstead/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# sst
export PATH=/Users/alistairstead/.sst/bin:$PATH
