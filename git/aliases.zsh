#!/bin/sh

alias gl='git pull --prune'
alias glg="git log --graph --decorate --oneline --abbrev-commit"
alias glga="glg --all"
alias gp='git push origin HEAD'
alias gpa='git push origin --all'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch -v'
alias ga='git add'
alias gaa='git add -A'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gs='git status -sb'
alias gcl='git clone'
alias gcb='git-copy-branch-name'
alias gpr='gp && git pr'

alias push='git push'
alias pull='git pull'

gi() {
  curl -s "https://www.gitignore.io/api/$*"
}

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
  if [[ $# -eq 0 ]]; then
    git commit -v
  else
    git commit -m "$args"
  fi
}

function gcnv() {
  args=$@
  if [[ $# -eq 0 ]]; then
    git commit --no-verify -v
  else
    git commit --no-verify -m "$args"
  fi
}

function gca() {
  args=$@
  git commit --amend -m "$args"
}

function gb() {
  local branch=$1
  git checkout -b $branch origin/$branch
}

alias gp='git push'

function gcp() {
  args=$@
  git commit -a -m "$args" && git push -u origin
}
