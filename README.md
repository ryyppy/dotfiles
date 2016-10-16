Dotfiles
==========

My dotfiles commonly used in an UNIX environment

Common Setup
=======

These steps need to be done without considering any target platform

```
#Install submodules
git submodule update --init --recursive

#Link all dotfiles in home-directory
bash install.sh
```

OSX "From Scratch" Setup
=======

If you are setting up your machine from scratch:

```
# Requires XCode to be installed
sudo xcodebuild -license

# Install brew -> http://brew.sh/
```

OSX Setup
=======

If you are using OSX and want to use the full configuration:

```
brew install tmux
brew install reattach-to-user-namespace
```

NVIM Setup
=======

The `nvim` directory contains the whole nvim configuration needed to get
everything running. Please be aware that `vimrc` and the `vim` directory are not
related to any neovim configuration and is completely independent from
eachother.

Right now I am transisting to neovim and the original `vimrc` & `vim` directory
will be obsolete, as soon as I decide to drop vanilla vim.

```
brew install neovim/neovim/neovim
brew install python3

# Install python nvim stuff (for remote plugins etc)
pip3 install neovim 

# Install dein plugin manager
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh installer.sh ~/.config/nvim/dein

# Open init.vim and install the plugins with `:call dein#install()`
nvim ~/.config/nvim/init.vim
```

Local independent configuration files
=======

Each machine has most likely (shell) configurations, which only make sense for the local context,
so create a `~/.zshrc.local` to apply additional settings. 

Notes
=====
* Install ESLint (npm, Syntastic)
* If you prefer vanilla VIM:
  * Use VIM-Version 7.4 or higher with python-support
	* Since vim-airline needs an adapted fontset (otherwise VIMs statusbar appears glitchy)
	 * ... either use prepatched fontset (https://github.com/Lokaltog/powerline-fonts)
	 * ... or patch your very own fontset (https://powerline.readthedocs.org/en/latest/fontpatching.html)


OSX Hints
=====

* VIM & Tmux & System Clipboard:
  * https://coderwall.com/p/j9wnfw
* Tmux + Clipboard
  * http://www.economyofeffort.com/2013/07/29/reattach-to-user-namespace-the-fix-for-your-tmux-in-os-x-woes/
