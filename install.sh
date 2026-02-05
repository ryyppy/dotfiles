#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"

echo $DIR

cd ~

[[ ! -s ~/.vim ]] && ln -s $DIR/vim ~/.vim
[[ ! -s ~/.emacs.d ]] && ln -s $DIR/emacs.d ~/.emacs.d
[[ ! -s ~/.vimrc ]] && ln -s $DIR/vimrc ~/.vimrc
[[ ! -s ~/.tmux.conf ]] && ln -s $DIR/tmux.conf ~/.tmux.conf
[[ ! -s ~/.ocamlinit ]] && ln -s $DIR/ocamlinit ~/.ocamlinit
[[ ! -s ~/.zshrc ]] && ln -s $DIR/zshrc ~/.zshrc

[[ ! -s ~/.config ]] && mkdir ~/.config
[[ ! -s ~/.config/nvim ]] && ln -s $DIR/nvim ~/.config/nvim
[[ ! -s ~/.config/starship.toml ]] && ln -s $DIR/starship.toml ~/.config/starship.toml
