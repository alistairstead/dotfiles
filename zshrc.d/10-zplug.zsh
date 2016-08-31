# Check if zplug is installed
if [[ ! -f "$HOME/.zplug/init.zsh" ]]; then
  git clone https://github.com/zplug/zplug "$HOME/.zplug/repos/zplug/zplug"
  ln -s "$HOME/.zplug/repos/zplug/zplug/init.zsh" "$HOME/.zplug/init.zsh"
fi

# Load zplug
source $HOME/.zplug/init.zsh

zplug "zplug/zplug"

zplug "plugins/brew", from:oh-my-zsh
zplug "plugins/brew-cask", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/composer", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/heroku", from:oh-my-zsh
zplug "plugins/httpie", from:oh-my-zsh
zplug "plugins/last-working-dir", from:oh-my-zsh
zplug "plugins/lol", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/symfony2", from:oh-my-zsh

#zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

zplug "tcnksm/docker-alias", use:zshrc

#zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"

zplug "knu/z", use:z.sh, nice:10
zplug "zsh-users/zsh-syntax-highlighting", nice:10
zplug "trapd00r/zsh-syntax-highlighting-filetypes", nice:10

zplug "zsh-users/zsh-history-substring-search"

##zplug "arialdomartini/oh-my-git"

zplug "sindresorhus/pure"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
