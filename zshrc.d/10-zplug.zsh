#Check if zplug is installed
if [[ ! -f "$HOME/.zplug/init.zsh" ]]; then
  git clone https://github.com/zplug/zplug "$HOME/.zplug/repos/zplug/zplug"
  ln -s "$HOME/.zplug/repos/zplug/zplug/init.zsh" "$HOME/.zplug/init.zsh"
fi

# Load zplug
source $HOME/.zplug/init.zsh

zplug "zplug/zplug"
zplug "marzocchi/zsh-notify"
zplug "tcnksm/docker-alias", \
      use:zshrc

#zplug "sorin-ionescu/prezto", use:"*.zsh"

zplug "knu/z", \
      use:z.sh, \
      nice:10


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

if zplug check zsh-users/zsh-autosuggestions; then
  bindkey '^ ' autosuggest-accept
fi

if zplug check zsh-users/zsh-syntax-highlighting; then
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

  # Aliases and functions
  ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'
  ZSH_HIGHLIGHT_STYLES[function]='fg=cyan,bold'

  # Commands and builtins
  ZSH_HIGHLIGHT_STYLES[command]="fg=green"
  ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=green,bold"
  ZSH_HIGHLIGHT_STYLES[builtin]="fg=green,bold"
  ZSH_HIGHLIGHT_STYLES[precommand]="fg=green,underline"
  ZSH_HIGHLIGHT_STYLES[commandseparator]="none"

  # Paths
  ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'

  # Globbing
  ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow,bold'

  # Options and arguments
  ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=red'
  ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=red'

  ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=green"
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=green"
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=green"
  ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=green"
  ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=green"

  # Patterns
  ZSH_HIGHLIGHT_PATTERNS+=('mv *' 'fg=white,bold,bg=red')
  ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
  ZSH_HIGHLIGHT_PATTERNS+=('sudo ' 'fg=white,bold,bg=red')#statements
fi
