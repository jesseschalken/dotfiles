autoload -U colors
colors

export EDITOR=vim

eval "$(dircolors -b)"

alias ls='ls --color'
alias grep='grep --color'

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory
setopt autocd
setopt autopushd
setopt beep
setopt menucomplete
setopt nomatch
setopt notify
setopt promptsubst
setopt pushdignoredups
setopt pushdsilent
setopt badpattern
setopt correct
setopt incappendhistory

bindkey -v
bindkey '^[[Z' reverse-menu-complete

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=1
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle :compinstall filename '/Users/jesseschalken/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

source ~/.git-completion.sh
PROMPT="%{$fg[grey]$bg[white]%}%~%{$reset_color%}\$(__git_ps1 \" %%{$(git config --get-color color.branch.current)%%}%s%%{\033[00m%%}\") %{$bold_color$fg[blue]$bg[blue]%}%#%{$reset_color%} "
LISTPROMPT=
