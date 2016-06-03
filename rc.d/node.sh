export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

source <(npm completion)
if [ -f /usr/local/bin/pm2 ]; then
  #statements
fi
source <(pm2 completion)
