# OH MY ZSHELL!
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh-custom
ZSH_THEME="couchbang"
DISABLE_AUTO_UPDATE="true"
plugins=(svn git mercurial vundle ruby cake rails3 gem bundler github)
source $ZSH/oh-my-zsh.sh


eval `dircolors`
export EDITOR='vim'
export TERM="xterm-256color"


# Aliases
alias wget='wget --trust-server-names'
alias svim='sudo vim'
#alias vcat='vim-cat'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Regular aliases (command only)
alias -r ..='cd ..'
alias -r ...='cd ../..'
alias -r ....='cd ../../..'
alias -r less='/usr/share/vim/vim73/macros/less.sh'

# Global aliases (parameter only)
alias -g ...='../..'
alias -g ....='../../..'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L='| less'
alias -g Q='> /dev/null'
alias -g S='&> /dev/null'


# When in X use GVim instead of Vim
#[ -z "$DISPLAY" ] || alias vim='gvim' # 2>/dev/null?

# Frequently used SSH session shortcuts
[ -f ~/.hosts ] && source ~/.hosts

PATH="${PATH}:${HOME}/.rvm/bin"
PATH="${PATH}:${HOME}/.bin"
PATH="${PATH}:${HOME}/.cabal/bin"


# Ripped from Ubuntu .bashrc
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# Add alert alias for long running commands: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# local zshrc:
[ -f ~/.zshrc.${HOST} ] && source ~/.zshrc.${HOST}


# MOTD
~/.bin/motd-nyan

