#!/usr/bin/env bash

DOTFILES_ROOT="`pwd`"
source "${DOTFILES_ROOT}/shared/common.sh"
manifest_file="${DOTFILES_ROOT}/manifest.txt"

set -e

install_dotfiles () {
  info "Starting Install\n"
  info "Installing from DOTFILES_ROOT :: ${DOTFILES_ROOT}\n"
  info "Reading manifest_file :: ${manifest_file}\n"
  manifest=$(<$manifest_file)

  overwrite_all=false
  backup_all=false
  skip_all=false
  nuke_all=false

  for source in $manifest
  do
    dest="${HOME}/${source}"
    source="${DOTFILES_ROOT}/${source}"


    if [ -L $dest ] || [ -f $dest ] || [ -d $dest ]
    then

      overwrite=false
      backup=false
      skip=false

      if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ] && [ "$nuke_all" == "false" ]
      then
        user "File already exists: ~/`basename $dest`, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all, [n]uke, [N]uke all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          n )
            overwrite=true
            skip=true;;
          N )
            overwrite_all=true
            skip_all=true;;
          * )
            ;;
        esac
      fi

      if [ "$overwrite" == "true" ] || [ "$overwrite_all" == "true" ]
      then
        remove_file $dest
      fi

      if [ "$backup" == "true" ] || [ "$backup_all" == "true" ]
      then
        move_file $dest $dest\.backup
      fi

      if [ "$skip" == "false" ] && [ "$skip_all" == "false" ]
      then
        link_file $source $dest
      else
        success "skipped $source"
      fi

    else
      link_file $source $dest
    fi

  done
}

echo ''
install_dotfiles
echo ''
exec $SHELL -l
echo '  Installed!'
