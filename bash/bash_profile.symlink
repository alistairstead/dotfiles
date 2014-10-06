# -*- mode: sh -*-

if [ -f $HOME/.bashrc ]; then
  source $HOME/.bashrc
fi

if [ "${TERM}" != "dumb" ]; then
  export CLICOLOR="cons25"
  export TERM=screen-256color

  export PS1="${PIN}${CYAN}\w ${BLUE}ruby:${RED}\$(current-ruby) ${BLUE}git:${GREEN}\$(current-git-branch)${RESET} ${GREY}»${RESET} "
fi
