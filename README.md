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
- Install ESLint (npm, Syntastic)
- Use VIM-Version 7.4 or higher with python-support
- Since vim-airline needs an adapted fontset (otherwise VIMs statusbar appears glitchy)
  ... either use prepatched fontset (https://github.com/Lokaltog/powerline-fonts)
  ... or patch your very own fontset (https://powerline.readthedocs.org/en/latest/fontpatching.html)


OSX Hints
=====
Tmux + Vim make some problems, you may need to install additional tools to make them
work as expected:

Install VIM + Powerline correctly:
- http://blog.codefront.net/2013/10/27/installing-powerline-on-os-x-homebrew/

brew install reattach-to-user-namespace

Sources:
- https://coderwall.com/p/j9wnfw
- http://www.economyofeffort.com/2013/07/29/reattach-to-user-namespace-the-fix-for-your-tmux-in-os-x-woes/


Terminal related tips
======

* I used iTerm2 for most of my TMUX sessions 
** http://plausiblethought.net/drop-down-terminal-with-iterm2/
