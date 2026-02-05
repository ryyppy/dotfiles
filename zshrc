export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export CLICOLOR=1

# Zsh completion (previously handled by oh-my-zsh)
# Cache completions, only rebuild once per day
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Unix specific bin paths 
export PATH=$HOME/dotfiles/bin:/usr/local/bin:/usr/local/sbin:$PATH

############
# Some useful aliases
############

# Git aliases
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gdca='git diff --cached'
alias gl='git pull'
alias gp='git push'
alias gst='git status'
alias gb='git branch'
alias glog='git log --oneline --decorate --graph'

#$1: path to search recursively
#$2: word to look for 
gref() {
    grep -rnw $1 -e $2
}

# Usage: extract_jira_ticket "branch-name"
# Will use the current Git branch if no branch name is provided
extract_jira_ticket() {
    local branch_name="$1"

    # If no branch name is provided, use the current Git branch
    if [[ -z "$branch_name" ]]; then
        branch_name=$(git rev-parse --abbrev-ref HEAD)
    fi

    # Use Zsh's =~ operator and access the matched parts
    if [[ $branch_name =~ '([A-Z]+-[0-9]+)(-.*)?' ]]; then
        echo "$match[1]"
    else
        echo "No Jira ticket found in the branch name."
    fi
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

# Alternative nvim config (kickstart.nvim)
alias nvim-kick='NVIM_APPNAME=nvim-kickstart nvim'

#Somehow this needs git
export GIT_EDITOR=vim

#Load the nvm path cache, if it exists
#This file is created with the custom .bin/cacheNvm script
#NVM_ENV_CACHE=~/.nvm_env_cache
#if [ -f "$NVM_ENV_CACHE" ]; then
  #export PATH=$(cat $NVM_ENV_CACHE):${PATH}
#fi

#Load local configuration not populated in the dotfiles repo
[[ -s $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

#Fuzzy finder configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
#[[ -f /Users/ryyppy/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/ryyppy/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
#[[ -f /Users/ryyppy/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/ryyppy/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh

# fnm
eval "$(fnm env)"

# Starship prompt
eval "$(starship init zsh)"
