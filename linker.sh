#!/usr/bin/env bash

cd $(dirname $0)/dotfiles
GLOBIGNORE=".:.."

# set -x

for f in .*
do
  result="${HOME}/$f"
  if [ -e "$result" ]
  then
    if [ -d "$result" ] && [ -L "$result" ]
    then
      echo "'$result' -> '$f' (already)"
    elif [ -f "$result" ] && [ -L "$result" ]
    then
      echo "$result is symbolic link to $f, should be hardlink"
      rm "$result"
    elif [ "$f" -ef "$result" ]
    then
      echo "'$result' => '$f' (already)"
    else
      echo "$f is a non-symlinked directory or non-hardlinked file"
      exit 1
    fi
  else
    if [ -d "$f" ]
    then
      ln -v -s "$(pwd)/$f" "$result"
    else
      ln -v "$f" "$result"
    fi
  fi
done

ln -f -v .profile ~/.zprofile
mkdir -p ~/.config
rm ~/.config/ranger
ln -f -s -v "$(pwd)/../special/ranger" ~/.config
