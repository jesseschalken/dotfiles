export EDITOR='vim'
export CLICOLOR='1'
export LESS='~RS'
export PAGER='less'
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true'

if brew --prefix coreutils > /dev/null 2>&1
then
	export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
	export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
fi

export PATH="$HOME/.local/bin:$PATH"
export MANPATH="$HOME/.local/man:$MANPATH"

eval "$(dircolors -b)"

