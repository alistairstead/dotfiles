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
# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/supercharge"
plug "zap-zsh/exa"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"

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

# Freshen up your brew.
freshbrew() {
  brew bump
  brew cleanup
  brew doctor
}

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


alias dockerps="docker ps --format 'table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}'"

function runr() {
  jq -r '.scripts | keys[]' package.json |
    fzf \
      --header="Select a script to run…" \
      --prompt="󰎙 Script  " \
      --preview "jq -r '.scripts | { \"{1}\" } | .[]' package.json" \
      --preview-window="down,1,border-horizontal" \
      --height="50%" \
      --layout="reverse" | \
    xargs -o npm run
}
alias cb='git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff {1} --color=always" --pointer="" | xargs git checkout'

alias alert='notify -t "Status" -m "Finished" -s Glass'

# https://gist.github.com/reegnz/b9e40993d410b75c2d866441add2cb55
function jqf() {
  echo "" | \
    fzf \
      --disabled \
      --print-query
      --preview "jq -C {q} $1" \
      --prompt="Query  " \
      --header="Interactive jq playground" \
      --preview-window="down:90"
}
function tzf() {
  tz -list | fzf -m | awk '{print $4}' | tr "\n" ";" | xargs -I {} sh -c "TZ_LIST='{}' tz"
}
function ghpr() {
  GH_FORCE_TTY=100% gh pr list | fzf --query "$1" --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout -f
}
function ghgist() {
  GH_FORCE_TTY=100% gh gist list --limit 20 | fzf --ansi --preview 'GH_FORCE_TTY=100% gh gist view {1}' --preview-window down | awk '{print $1}' | xargs gh gist edit
}

# git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/AstroNvim
# git clone git@github.com:nvim-lua/kickstart.nvim.git ~/.config/kickstart
# git clone https://github.com/nvim-lua/kickstart.nvim.git ~/.config/kickstart
# git clone https://github.com/NvChad/NvChad ~/.config/NvChad --depth 1
# git clone https://github.com/LazyVim/starter ~/.config/LazyVim
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
function nvims() {
  items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
bindkey "^a" "nvims\n"

local dev_commands=(
	'tz' 'task' 'watson' 'archey' 'ncdu'
	'fkill' 'lazydocker' 'ntl' 'ranger'
	'speed-test' 'serve' 'vtop' 'htop' 'btop'
	'lazygit' 'gitui' 'tig' 'tldr'
  'calcurse' 'cmatrix' 'cowsay' 'exa' 'fd' 'dooit' 'taskell' 'gh' 'gitui' 'hyperfine' 'lolcat'
  'mc' 'navi' 'neofetch' 'newsboat' 'nnn' 'tree' 'vhs' 'vifm' 'zellij' 'tmux' 'zoxide'
)
alias dev='printf "%s\n" "${dev_commands[@]}" | fzf --height 20% --header Commands | bash'

# bindkey -s ^f "zellij-switch\n"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -r ~/private/.zshrc ] && source ~/private/.zshrc

# Load and initialise completion system
autoload -Uz compinit
compinit

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

