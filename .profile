# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
    fi
fi

export EDITOR='vim'
export CLICOLOR='1'
export LESS='~RSx4'
export PAGER='less'
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true'
export LSCOLORS='ExFxCxDxBxegedabagacad'

if brew --prefix coreutils > /dev/null 2>&1
then
	export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
	export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
fi

export PATH="$HOME/.local/bin:$PATH"
export MANPATH="$HOME/.local/man:$MANPATH"

if command -v dircolors > /dev/null 2>&1
then
    eval "$(dircolors -b)"
fi


