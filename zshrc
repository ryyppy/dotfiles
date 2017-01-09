# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gallifrey"

# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

# Unix specific bin paths 
export PATH=$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH

############
# Some useful aliases
############

#$1: path to search recursively
#$2: word to look for 
gref() {
    grep -rnw $1 -e $2
}

# Highlight files and copy to clipboard
# style=monokai for dark bg, style=tango for light bg
#function hl() {
  #PYGMENTS_NODE_COMMAND=node pygmentize -f rtf -O style=tango,fontface=Inconsolata,font_size=42 $* | sed 's;\\f0;\\f0\\fs84;g' | tr -d '\n' | sed 's;\\par}$;};' | pbcopy
#}

#function hljs() {
  #hl -l jsx $*
#}

# pbpaste | hljs -> If you highlight js
# pbpaste | hl -> For everything else

#Load OS specific configurations
if [[ `uname` = 'Darwin' ]]; then
    #Prevent visual bugs because of german encoding
    LANG=en_US.UTF-8
    LC_ALL=en_US.UTF-8

		alias flow='$(npm-which flow)'
		alias eslint='$(npm-which eslint)'

    export PATH=/usr/local/share/npm/bin:$PATH
    export PATH=~/.scripts:$PATH
    export PATH=/usr/texbin:$PATH
elif [[ `uname` = 'Linux' ]]; then
    export PATH="$PATH:/opt/node/bin"
fi

command -v nvim > /dev/null 2>&1 && { alias vim='nvim'; alias nvimdiff='nvim -d'; }

#Somehow this needs git
export GIT_EDITOR=vim

#Load local configuration not populated in the dotfiles repo
[[ -s $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

#Initialize the Oh-My-Zsh framework
source $ZSH/oh-my-zsh.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#Fuzzy finder configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="/Users/ps/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
