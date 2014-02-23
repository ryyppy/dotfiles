#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"


echo $DIR

cd ~

ln -s $DIR/vim .vim
ln -s $DIR/vimrc .vimrc
ln -s $DIR/jshintrc .jshintrc
ln -s $DIR/tmux.conf .tmux.conf
ln -s $DIR/oh-my-zsh .oh-my-zsh
ln -s $DIR/zshrc .zshrc
ln -s $DIR/bin .bin
