
COMPLETION_WAITING_DOTS="true"
ZSH=$HOME/.oh-my-zsh
plugins=(git vi-mode brew node git-flow github arch-linux)
source $ZSH/oh-my-zsh.sh

source ~/.zprofile

KEYTIMEOUT=1

if [ $EUID = 0 ]
then
	PROMPT="%{$fg[grey]$bg[white]%}%~%{$reset_color%} %{$bold_color$fg[red]$bg[red]%}λ%{$reset_color%} "
else
	PROMPT="%{$fg[grey]$bg[white]%}%~%{$reset_color%} %{$bold_color$fg[blue]$bg[blue]%}λ%{$reset_color%} "
fi

MODE_INDICATOR="%{$bold_color%}NORMAL%{$reset_color%} "
RPROMPT="\$(vi_mode_prompt_info)%{"$'\e'"[$color[faint]m%}%n@%M%{$reset_color%}"

setopt appendhistory
setopt autocd
setopt autopushd
setopt badpattern
setopt beep
setopt completealiases
setopt globcomplete
setopt incappendhistory
setopt menucomplete
setopt multios
setopt nocorrect
setopt nocorrectall
setopt nomatch
setopt nosharehistory
setopt notify
setopt promptsubst
setopt pushdignoredups
setopt pushdsilent
setopt pushdtohome
setopt zle
setopt histignoredups
setopt histignorealldups
setopt histreduceblanks
setopt incappendhistory
setopt sharehistory

bindkey -v
bindkey '^[[Z' reverse-menu-complete
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey '\e[2~' overwrite-mode
bindkey '\e[3~' delete-char
bindkey -M vicmd '^[' vi-cmd-mode

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

function cd() {
	if (( ARGC == 0 ))
	then
		popd
	else
		builtin cd "$@"
	fi
}

