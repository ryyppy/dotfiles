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

HERDR_CONFIG_DIR="$HOME/.config/herdr"
mkdir -p "$HERDR_CONFIG_DIR"
HERDR_CONFIG="$HERDR_CONFIG_DIR/config.toml"
if [[ ! -e "$HERDR_CONFIG" ]]; then
  ln -s "$DIR/herdr/config.toml" "$HERDR_CONFIG"
elif [[ -f "$HERDR_CONFIG" && ! -L "$HERDR_CONFIG" ]] && cmp -s "$DIR/herdr/config.toml" "$HERDR_CONFIG"; then
  rm "$HERDR_CONFIG"
  ln -s "$DIR/herdr/config.toml" "$HERDR_CONFIG"
fi

# Link only portable Pi config, not the entire private agent directory.
PI_AGENT_DIR="${PI_CODING_AGENT_DIR:-$HOME/.pi/agent}"
mkdir -p "$PI_AGENT_DIR"
for file in settings.json keybindings.json; do
  source="$DIR/pi/$file"
  target="$PI_AGENT_DIR/$file"
  if [[ ! -e "$target" && ! -L "$target" ]]; then
    ln -s "$source" "$target"
  elif [[ -f "$target" && ! -L "$target" ]] && cmp -s "$source" "$target"; then
    rm "$target"
    ln -s "$source" "$target"
  elif [[ ! -L "$target" || "$(readlink "$target")" != "$source" ]]; then
    printf 'Skipping existing Pi config (not overwritten): %s\n' "$target"
  fi
done

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
