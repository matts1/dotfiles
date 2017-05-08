#!/usr/bin/env bash

sudo apt update

sudo apt install neovim

sudo apt install git zsh unity-tweak-tool thefuck

sudo apt install python2-dev python2-pip
sudo apt install python3-dev python3-pip
pip3 install --user thefuck

sudo apt install cabal-install hoogle hlint dconf-tools
cabal update
cabal install quickcheck
cabal install happy
cabal install ghc-mod
cabal install codex

sudo apt install hasktags
