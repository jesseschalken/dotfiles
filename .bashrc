PS1='\[\033[30;47m\]\w\[\033[00m\] \[\033[01;34;44m\]\$\[\033[00m\] '

if [ -f /etc/DIR_COLORS ]; then
	eval "$(dircolors -b /etc/DIR_COLORS)"
else
	eval "$(dircolors -b)"
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
