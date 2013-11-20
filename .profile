export EDITOR=vim
export GREP_OPTIONS='--color=auto'
export CLICOLOR=1
export LESS=~RS
export SHELL=zsh
export PAGER=less

if brew --prefix coreutils > /dev/null 2>&1
then
	export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
	export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
fi

export PATH="$HOME/.local/bin:$PATH"
export MANPATH="$HOME/.local/man:$MANPATH"

eval "$(dircolors -b)"

if [ "$COLORTERM" = 'gnome-terminal' ]
then
	export TERM=xterm-256color
fi

