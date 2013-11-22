# OH MY ZSHELL!
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh-custom
ZSH_THEME="power-wombat"
DISABLE_AUTO_UPDATE="true"
plugins=(svn git mercurial vundle github debian command-not-found mvn pip nyan)
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
alias -r cdr='cd $PROJECT_ROOT'
alias -r p='pushd'
alias -r o='popd'
alias -r pdr='pushd $PROJECT_ROOT'

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


# Ripped from Ubuntu .bashrc
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# Add alert alias for long running commands: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# MOTD
~/.bin/motd-nyan


# Local bin
export PATH=$PATH:$HOME/.bin
# RVM path
export PATH=$PATH:$HOME/.rvm/bin
# Cabal path
export PATH=$PATH:$HOME/.cabal/bin

# Java home
export JAVA_HOME='/usr/lib/jvm/default-java'
# Jetty home
export JETTY_HOME='/usr/share/jetty8'

# Eclipse home
export ECLIPSE_HOME='/home/michael/.eclipse/org.eclipse.platform_3.8_155965261'
# Run eclimd (only once)
[ -z "$(ps aux|grep eclimd|grep -v grep)" ] && screen -dmS eclimd $ECLIPSE_HOME/eclimd


reverseFind() {
    RES="$PWD"
    while [ "$RES" != "/" ] ; do
        ls -a "$RES" | grep "^$1$" >/dev/null && echo "$RES" && break
        RES=$(dirname $RES)
    done
    unset RES
}

export PROJECT_ROOT="$HOME/src"
findRepo() {
    [[ "$PROJECT_ROOT" == "$PWD" ]] && return
    [[ "$PROJECT_ROOT" != "$HOME/src" ]] && [[ "$PWD" == "$PROJECT_ROOT*" ]]
    export PROJECT_ROOT="$HOME/src"
    #for FOLDER in .svn .git ; do
    #    DIR=$(reverseFind $FOLDER)
    #    [ -n "$DIR" ] && export PROJECT_ROOT=$DIR && break
    #done
    DIR=$(reverseFind '.svn')
    [ -n "$DIR" ] && export PROJECT_ROOT=$DIR
    unset DIR
}
findRepo

chpwd_functions+=(findRepo)


# local zshrc:
[ -f ~/.zshrc.${HOST} ] && source ~/.zshrc.${HOST}

