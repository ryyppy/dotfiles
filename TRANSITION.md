# Transition from NvChad to Kickstart.nvim

Once you're happy with the kickstart config, follow these steps:

## 1. Replace nvim with kickstart

```bash
cd ~/dotfiles
rm -rf nvim
mv nvim-kickstart nvim
```

## 2. Remove the nvim-kick alias from zshrc

Remove this line from `zshrc`:
```zsh
alias nvim-kick='NVIM_APPNAME=nvim-kickstart nvim'
```

## 3. Update install.sh

Remove this line from `install.sh`:
```bash
[[ ! -s ~/.config/nvim-kickstart ]] && ln -s $DIR/nvim-kickstart ~/.config/nvim-kickstart
```

## 4. Clean up symlinks

```bash
rm ~/.config/nvim-kickstart
```

## 5. Commit and merge

```bash
cd ~/dotfiles
git add -A && git commit -m "Switch to kickstart.nvim as default"
git checkout main && git merge try-kickstart
git branch -d try-kickstart
git push
```

## 6. Clear old NvChad data (optional)

```bash
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

Next time you run `nvim`, it will use kickstart and reinstall plugins.
