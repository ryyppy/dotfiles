Dotfiles
==========

My dotfiles commonly used in an UNIX environment

Install
=======
bash install.sh

Notes
=====
- Install JSHint (npm, Syntastic)
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


Optional configuration related to Terminal
======
- iTerm2 configuration as Visor
-- http://plausiblethought.net/drop-down-terminal-with-iterm2/
