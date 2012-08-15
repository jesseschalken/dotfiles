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

autoload -U colors
colors

export PATH=~/homebrew/bin:$PATH
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export EDITOR=vim

eval "$(dircolors -b)"

alias ls='ls -lah --color=auto'

export GREP_OPTIONS='--color=auto'

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
setopt incappendhistory

bindkey -v
bindkey '^[[Z' reverse-menu-complete
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line

source ~/.git-completion.sh
PROMPT="%{$fg[grey]$bg[white]%}%~%{$reset_color%}\$(__git_ps1 \" %%{$(git config --get-color color.branch.current)%%}%s%%{\033[00m%%}\") %{$bold_color$fg[blue]$bg[blue]%}%#%{$reset_color%} "

RPROMPT_REAL="%{$bold_color$fg[grey]%}%n@%M%{$reset_color%}"

NORMAL_MODE="%{$bold_color%}NORMAL%{$reset_color%} "

function zle-line-init zle-keymap-select {
	RPS1="${${KEYMAP/vicmd/$NORMAL_MODE}/(main|viins)/}$RPROMPT_REAL"
	RPS2=$RPS1
	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
