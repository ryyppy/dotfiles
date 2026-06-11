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
[[ ! -s ~/.config/starship.toml ]] && ln -s $DIR/starship.toml ~/.config/starship.toml

if [[ "$(uname)" == "Darwin" ]]; then
  LAZYGIT_CONFIG_DIR="$HOME/Library/Application Support/lazygit"
else
  LAZYGIT_CONFIG_DIR="$HOME/.config/lazygit"
fi

mkdir -p "$LAZYGIT_CONFIG_DIR"
LAZYGIT_CONFIG="$LAZYGIT_CONFIG_DIR/config.yml"
if [[ ! -e "$LAZYGIT_CONFIG" ]]; then
  ln -s "$DIR/lazygit/config.yml" "$LAZYGIT_CONFIG"
elif [[ -f "$LAZYGIT_CONFIG" && ! -s "$LAZYGIT_CONFIG" && ! -L "$LAZYGIT_CONFIG" ]]; then
  rm "$LAZYGIT_CONFIG"
  ln -s "$DIR/lazygit/config.yml" "$LAZYGIT_CONFIG"
fi
