# alistairstead/dotfiles test container
FROM ubuntu
MAINTAINER Alistair Stead <alistair_stead@me.com>

RUN apt-get install -y software-properties-common wget zsh git curl python

COPY . /root/.dotfiles

RUN cd /root/.dotfiles && \
./script/bootstrap && \
zsh -c "source ~/.zshrc" || true

ENTRYPOINT zsh
