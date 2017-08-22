#!/bin/bash

if [[ `uname` = 'Darwin' ]]; then
  brew tap caskroom/cask
  brew tap caskroom/versions
  brew tap neovim/neovim
fi
