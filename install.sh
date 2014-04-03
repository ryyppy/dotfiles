#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"

echo $DIR

cd ~

[[ ! -s ~/.vim ]] && ln -s $DIR/vim ~/.vim
[[ ! -s ~/.vimrc ]] && ln -s $DIR/vimrc ~/.vimrc
[[ ! -s ~/.jshintrc ]] && ln -s $DIR/jshintrc ~/.jshintrc
[[ ! -s ~/.tmux.conf ]] && ln -s $DIR/tmux.conf ~/.tmux.conf
[[ ! -s ~/.oh-my-zsh ]] && ln -s $DIR/oh-my-zsh ~/.oh-my-zsh
[[ ! -s ~/.zshrc ]] && ln -s $DIR/zshrc ~/.zshrc
[[ ! -s ~/.bin ]] && ln -s $DIR/bin ~/.bin

[[ ! -s ~/.config ]] && mkdir ~/.config
[[ ! -s ~/.config/powerline ]] && ln -s $DIR/powerline  ~/.config/powerline
