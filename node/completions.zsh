#!/bin/sh

if [ -f /usr/local/bin/npm ]; then
  source <(npm completion)
fi
if [ -f /usr/local/bin/pm2 ]; then
  #statements
  source <(pm2 completion)
fi
