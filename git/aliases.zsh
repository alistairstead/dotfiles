# Git short-cuts.
alias g='git'
alias ga='git add'
alias gau='git add --update && git status --short'
alias gr='git rm'

alias gf='git fetch'
alias gu='git pull'
alias gup='git pull && git push'

alias gs='git status --short'
alias gd='git diff'
alias gds='git diff --staged'
alias gdisc='git discard'

function gc() {
  args=$@
  git commit -m "$args"
}
function gca() {
  args=$@
  git commit --amend -m "$args"
}

alias gp='git push'

function gcp() {
  args=$@
  git commit -a -m "$args" && git push -u origin
}
alias gcl='git clone'
alias gch='git checkout'
alias gl='git log --no-merges'
