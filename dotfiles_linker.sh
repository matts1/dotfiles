#!/usr/bin/env bash

cd $(dirname $0)/dotfiles
GLOBIGNORE=".:.."

for f in .*
do
  result="/home/matt/$f"
  if [[ ! -L "$result" ]]
  then
    if [[ -e "$result" ]]
    then
      echo "File $f already exists and is not a symlink"
      exit 1
    fi
    ln -f -s "$(pwd)/$f" "$result"
  fi
done

ln -f -s "$(pwd)/nvim" ~/.config/nvim
rm -f ~/.config/nvim/nvim
ln -f -s "$(pwd)/.profile" /home/matt/.zprofile
