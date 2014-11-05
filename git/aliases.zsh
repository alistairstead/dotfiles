# Git short-cuts.
alias ga='git add'
alias gau='git add --update && git status --short'
alias gco='git checkout'
alias gr='git rm'

alias gf='git fetch'
alias gu='git pull'
alias gup='git pull && git push'

alias gs='git status --short'
alias gd='git diff'
alias gds='git diff --staged'
alias gdisc='git discard'

function g() {
  args=$@
  if [[ $# -eq 0 ]]; then
    git status --short
  else
    git $args
  fi
}

function gc() {
  args=$@
  git commit -m "$args"
}
function gca() {
  args=$@
  git commit --amend -m "$args"
}

function gf() {
  local branch=$1
  git checkout -b $branch origin/$branch
}

alias gp='git push'

function gcp() {
  args=$@
  git commit -a -m "$args" && git push -u origin
}
alias gcl='git clone'
alias gch='git checkout'
alias gl='git log --no-merges'

alias push='git push'
alias pull='git pull'
