# ZSH config

Here is a non-exclusive list of what each file tends to contain:

1. Since .zshenv is always sourced, it often contains exported variables that should be available to other programs. For example, $PATH, $EDITOR, and $PAGER are often set in .zshenv. Also, you can set $ZDOTDIR in .zshenv to specify an alternative location for the rest of your zsh configuration.
2. .zprofile is basically the same as .zlogin except that it's sourced before .zshrc while .zlogin is sourced after .zshrc. According to the zsh documentation, ".zprofile is meant as an alternative to .zlogin for ksh fans; the two are not intended to be used together, although this could certainly be done if desired."
3. .zshrc is for interactive shell configuration. You set options for the interactive shell there with the setopt and unsetopt commands. You can also load shell modules, set your history options, change your prompt, set up zle and completion, et cetera. You also set any variables that are only used in the interactive shell (e.g. $LS_COLORS).
4. .zlogin is sourced on the start of a login shell but after .zshrc if the shell is also interactive. This file is often used to start X using startx. Some systems start X on boot, so this file is not always very useful.

## Order of file evaluation

Just for my own notes / confirmation and to help anybody else, the ultimate order is:

```
.zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes]
```
