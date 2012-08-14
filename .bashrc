PS1='\[\033[30;47m\]\w\[\033[00m\]$(__git_ps1 " \[$(git config --get-color color.branch.current)\]%s\[\033[00m\]") \[\033[01;34;44m\]\$\[\033[00m\] '

eval "$(dircolors -b)"

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#export GIT_PS1_SHOWDIRTYSTATE=1
#export GIT_PS1_SHOWUNTRACKEDFILES=1
#export GIT_PS1_SHOWUPSTREAM=verbose

source ~/.git-completion.sh
