#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"

echo $DIR

cd ~

[[ ! -s ~/.vim ]] && ln -s $DIR/vim ~/.vim
[[ ! -s ~/.vimrc ]] && ln -s $DIR/vimrc ~/.vimrc
[[ ! -s ~/.tmux.conf ]] && ln -s $DIR/tmux.conf ~/.tmux.conf
[[ ! -s ~/.zshrc ]] && ln -s $DIR/zshrc ~/.zshrc

[[ ! -s ~/.config ]] && mkdir ~/.config
[[ ! -s ~/.config/nvim ]] && ln -s $DIR/nvim ~/.config/nvim
[[ ! -s ~/.config/nvim-kickstart ]] && ln -s $DIR/nvim-kickstart ~/.config/nvim-kickstart
[[ ! -s ~/.config/starship.toml ]] && ln -s $DIR/starship.toml ~/.config/starship.toml
