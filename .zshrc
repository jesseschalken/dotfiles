export EDITOR=vim
export GREP_OPTIONS='--color=auto'

ZSH=$HOME/.oh-my-zsh
COMPLETION_WAITING_DOTS="true"
plugins=(git vi-mode brew node)
source $ZSH/oh-my-zsh.sh

KEYTIMEOUT=1
PROMPT="%{$fg[grey]$bg[white]%}%~%{$reset_color%}\$(__git_ps1 \" %%{$(git config --get-color color.branch.current)%%}%s%%{\033[00m%%}\") %{$bold_color$fg[blue]$bg[blue]%}λ%{$reset_color%} "
MODE_INDICATOR="%{$bold_color%}NORMAL%{$reset_color%} "
RPROMPT="\$(vi_mode_prompt_info)%{"$'\e'"[$color[faint]m%}%n@%M%{$reset_color%}"

eval "$(dircolors -b)"

autoload -U colors
colors

alias ls='ls --color=auto'

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
setopt incappendhistory

bindkey -v
bindkey '^[[Z' reverse-menu-complete
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey -M vicmd '^[' vi-cmd-mode

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

