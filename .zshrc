
ZSH=$HOME/.oh-my-zsh
COMPLETION_WAITING_DOTS="true"
plugins=(git vi-mode brew node git-flow github)
. $ZSH/oh-my-zsh.sh
. ~/.zprofile

KEYTIMEOUT=1
PROMPT="%{$fg[grey]$bg[white]%}%~%{$reset_color%} %{$bold_color$fg[blue]$bg[blue]%}λ%{$reset_color%} "
MODE_INDICATOR="%{$bold_color%}NORMAL%{$reset_color%} "
RPROMPT="\$(vi_mode_prompt_info)%{"$'\e'"[$color[faint]m%}%n@%M%{$reset_color%}"

autoload -U colors
colors

alias ls='ls --color=auto'

setopt appendhistory
setopt autocd
setopt autopushd
setopt badpattern
setopt beep
setopt completealiases
setopt incappendhistory
setopt menucomplete
setopt nocorrect
setopt nocorrectall
setopt nomatch
setopt nosharehistory
setopt notify
setopt promptsubst
setopt pushdignoredups
setopt pushdsilent

bindkey -v
bindkey '^[[Z' reverse-menu-complete
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey -M vicmd '^[' vi-cmd-mode

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -Uz compinit
compinit

