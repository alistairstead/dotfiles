if test -d $fish_path/completions
  set fish_complete_path $fish_path/completions $fish_complete_path
end

set -g -x PATH "$HOME/bin"               $PATH

set -g -x fish_greeting 'Would you like to play a game?'
set -g -x EDITOR 'vim'
set -g -x COMMAND_MODE unix2003
set -g -x RUBYOPT rubygems
# set -g -x JAVA_HOME "/usr"

set -g -x MINK_EXTENSION_PARAMS 'show_auto=true&show_cmd=open %s'

# set -g -x DEBUG 'express:*'

#set -g -x NODE_ENV 'development'

alias copy 'pbcopy'
alias paste 'pbpaste'

alias ga 'git add'
make_completion ga 'git add'
alias gap 'git add -p'
make_completion gap 'git add -p'
alias gau 'git add -u'
make_completion gau 'git add -u'
alias gb 'git branch'
make_completion gb 'git branch'
alias gc 'git commit -v'
make_completion gc 'git commit -v'
alias gc! 'git commit'
make_completion gc! 'git commit'
alias gco 'git checkout'
make_completion gco 'git checkout'
alias gp 'git push'
make_completion gp 'git push'
alias gs 'git status --short'
make_completion gs 'git status --short'

# List direcory contents
alias lsa 'ls -lah'
alias l 'ls -la'
alias ll 'ls -l'
alias ls 'ls -G'
alias ll 'ls -lG'
alias sl 'ls' # often screw this up

# programs
alias preview "open -a '$PREVIEW'"
alias xcode "open -a '/Developer/Applications/Xcode.app'"
alias filemerge "open -a '/Developer/Applications/Utilities/FileMerge.app'"
alias Safari "open -a Safari"
alias Firefox "open -a Firefox"
alias Opera "open -a Opera"
alias Chrome "open -a Google\ Chrome"
alias Canary "open -a Google\ Chrome\ Canary"
alias Chromium "open -a Chromium"
alias dashcode "open -a Dashcode"
alias f 'open -a Finder'
alias startredis 'redis-server /usr/local/etc/redis.conf &'
alias startmongo 'mongod &'
alias startnode "foreman start -e dev.env"
# general shortcuts
alias src "cd ~/src"
alias sites "cd ~/Sites"
alias gh "open -a Google\ Chrome\ Canary 'http://github.com/alistairstead'"
alias bl "open -a Google\ Chrome\ Canary 'http://browserling.com'"

alias :q "fail"

# TextMate
alias et "mate"
alias ett "mate ."

alias sub "subl"
alias hosts "sudo e /etc/hosts"

# php
alias phpa 'php -a'
alias phpv 'php -v'
alias s 'phpspec'
alias d 'phpspec describe'
alias b 'behat'
# Vagrant
alias vu 'vagrant up'
alias vp 'vagrant provision'
alias vr 'vagrant reload'
alias vs 'vagrant ssh'
alias vh 'vagrant halt'
alias vd 'vagrant destroy'

# vim
alias v 'vim'
alias V 'vim'


alias db "cd ~/Dropbox"
alias dl "cd ~/Downloads"
alias dt "cd ~/Desktop"
alias j "jobs"

alias retag 'ctags -R --exclude=.svn --exclude=.git --exclude=log --exclude=tmp *'

alias tmux "env TERM=screen-256color-bce tmux"

alias editfish "$EDITOR ~/.config/fish"

alias wotgobblemem 'ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6 | tail -15'
alias wotgobblecpu 'ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 5 | tail -15'


alias expand "extract"
alias inflate "extract"


# View HTTP traffic
alias sniff "sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump "sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS
    alias "$method" "lwp-request -m '$method'"
end

#sssh (){ ssh -t "$1" 'tmux attach || tmux new || screen -DR'; }

# IP addresses
alias ip "dig +short myip.opendns.com @resolver1.opendns.com"
alias localip "ipconfig getifaddr en0"
alias ips "ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Enhanced WHOIS lookups
alias whois "whois -h whois-servers.net"

# Flush Directory Service cache
alias flush "dscacheutil -flushcache"

# Empty the Trash on all mounted volumes and the main HDD
alias emptytrash "sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash"
alias remount "sudo kextunload /System/Library/Extensions/AppleStorageDrivers.kext/Contents/PlugIns/AppleUSBCardReader.kext; sudo kextload /System/Library/Extensions/AppleStorageDrivers.kext/Contents/PlugIns/AppleUSBCardReader.kext"

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu "osascript -e 'set volume output muted true'"
alias pumpitup "osascript -e 'set volume 4'"
alias hax "growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"


# Heroku
alias hconsole 'heroku run'
alias htail 'heroku logs --tail'


# # Heroku databases
alias db-pull-staging 'heroku db:pull --remote staging --confirm `basename $PWD`-staging'
alias db-pull-production 'heroku db:pull --remote production --confirm `basename $PWD`-production'
alias db-copy-production-to-staging 'heroku pgbackups:restore DATABASE `heroku pgbackups:url --remote production` --remote staging  --confirm `basename $PWD`-staging'
alias db-backup-production 'heroku pgbackups:capture --remote production'
alias db-backups 'heroku pgbackups --remote production'

# Pipe my public key to my clipboard. Fuck you, pay me.
alias pubkey "more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias copykey 'pubkey'

test -s $HOME/.config/fish/boxen.fish; and source $HOME/.config/fish/boxen.fish

test -s $HOME/.config/fish/private.fish; and source $HOME/.config/fish/private.fish

varclear PATH fish_complete_path
