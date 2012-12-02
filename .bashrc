shopt -s autocd
shopt -s histappend
shopt -s extglob
shopt -s cdspell
set -o vi

PS1='\[\033[30;47m\]\w\[\033[00m\] \[\033[01;34;44m\]\$\[\033[00m\] '

HISTCONTROL=ignoredups
HISTFILESIZE=1000000000
HISTSIZE=1000000

alias ls='ls --color=auto'
