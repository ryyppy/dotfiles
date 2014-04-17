# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gallifrey"

# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

# Unix specific bin paths 
export PATH=$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH

# Addon script powerline... override it when needed
POWERLINE_ZSH="/usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh"

#Load OS specific configurations
if [[ `uname` = 'Darwin' ]]; then
    #Prevent visual bugs because of german encoding
    LANG=en_US.UTF-8
    LC_ALL=en_US.UTF-8

    export PATH=/usr/local/share/npm/bin:$PATH
    export PATH=~/.scripts:$PATH
    export PATH=/usr/texbin:$PATH

elif [[ `uname` = 'Linux' ]]; then
    POWERLINE_ZSH="~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh"

    export PATH=/opt/node/bin:$PATH
fi


#Load local configuration not populated in the dotfiles repo
[[ -s $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

#Initialize the Oh-My-Zsh framework
source $ZSH/oh-my-zsh.sh

#Powerline needs to be initialized after oh-my-zsh
#[[ -s $POWERLINE_ZSH ]] && source $POWERLINE_ZSH 
