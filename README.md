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

MacOS Setup
=======

If you are using MacOS and want to use the full configuration:

```
brew install tmux
brew install reattach-to-user-namespace

# needed for the `ag` command that is used together with fzf in nvim
brew install the_silver_searcher

# For node management (https://github.com/Schniz/fnm)
brew install fnm
```

Python Setup
=======

Make sure to install python correctly with `pyenv` first.

```
brew install pyenv
```

After that, follow the pyenv instructions to install a python@3 based environment.

NVIM Setup
=======

The `nvim` directory contains everything you need to get running (except the
plugin manager). Make sure to link all directories first, otherwise `.config/nvim`
doesn't exist yet.

```
brew install neovim

# Requires pyenv to be configured correctly by now!
pip install pynvim

# Install vim-plug
curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Open init.vim and install all the plugins with `:PlugInstall`
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


**Key Repeat:**

```sh
defaults write -g InitialKeyRepeat -int 13
defaults write -g KeyRepeat -int 2
```
