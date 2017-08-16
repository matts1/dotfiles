#!/usr/bin/env bash

sudo apt update

sudo apt install neovim

sudo apt install git zsh unity-tweak-tool

sudo pip2 install neovim
sudo pip3 install neovim
sudo pip3 install gitsome

sudo apt install python2-dev python2-pip
sudo apt install python3-dev python3-pip
sudo pip install pyclewn

#sudo apt install cabal-install hoogle hlint dconf-tools
#cabal update
#cabal install quickcheck
#cabal install happy
#cabal install ghc-mod
#cabal install codex
#sudo apt remove cabal-install

#sudo apt install hasktags

sudo apt install highlight # required for ranger

git clone git@github.com:ranger/ranger.git
cd ranger
sudo make install
cd -
sudo rm -rf ../ranger
