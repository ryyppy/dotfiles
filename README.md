Dotfiles
==========

My dotfiles commonly used in an UNIX environment

Common Prerequisites
=======

These steps need to be done without considering any target platform

```
#Install submodules
git submodule update --init --recursive

#Link all dotfiles in home-directory
bash install.sh
```

OSX From Scratch Prerequisites
=======

If you are setting up your machine from scratch:

```
# Requires XCode to be installed
sudo xcodebuild -license

# Install brew -> http://brew.sh/
```

OSX Prerequisites
=======

If you are using OSX and want to use the full configuration:

```
brew install tmux
brew install reattach-to-user-namespace
```

Local independent configuration files
=======

Each machine has most likely (shell) configurations, which only make sense for the local context,
so create a `~/.zshrc.local` to apply additional settings. 

Notes
=====
* Install ESLint (npm, Syntastic)
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
