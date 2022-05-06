# Download Znap, if it's not there yet.
ZDOTDIR="$HOME/.znap"
ZNAPDIR="$ZDOTDIR/zsh-snap"
ZNAP_ZSH="$ZNAPDIR/znap.zsh"

[[ -f "$ZDOTDIR/zsh-snap/znap.zsh" ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git "$ZDOTDIR/zsh-snap"

if [[ -a $ZNAP_ZSH ]]; then
    source $ZNAP_ZSH
    # `znap prompt` makes your prompt visible in just 15-40ms!
    # znap prompt sindresorhus/pure

    # The same goes for any other kind of custom prompt:
    znap eval starship 'starship init zsh'
    znap prompt

    # `znap source` automatically downloads and starts your plugins.
    znap source mafredri/zsh-async
    znap source marlonrichert/zsh-autocomplete
    znap source zsh-users/zsh-completions
    znap source zsh-users/zsh-autosuggestions
    znap source zsh-users/zsh-history-substring-search
    znap source ael-code/zsh-colored-man-pages

    ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )
    znap source zsh-users/zsh-syntax-highlighting

    ##
    # Cache the output of slow commands with `znap eval`.
    znap eval direnv/direnv "$(direnv hook zsh)"


    # The cache gets regenerated, too, when the eval command has changed. For
    # example, here we include a variable. So, the cache gets invalidated whenever
    # this variable has changed.
    znap source marlonrichert/zcolors
    znap eval   marlonrichert/zcolors "zcolors ${(q)LSCOLORS}"

    # Combine `znap eval` with `curl` or `wget` to download, cache and source
    # individual files:
    znap eval omz-git 'curl -fsSL \
        https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh'

    # `znap eval` caches and runs any kind of command output for you.
    znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'

fi
