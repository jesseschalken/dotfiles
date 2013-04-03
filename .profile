export EDITOR=vim
export GREP_OPTIONS='--color=auto'
export CLICOLOR=1
export LESS='FRSXx8'
export SHELL=zsh
export PAGER=less

if [ -d "$HOME/homebrew/" ]
then
	export PATH="$HOME/homebrew/bin:$HOME/homebrew/sbin:$PATH"
	export MANPATH="$HOME/homebrew/share/man:$MANPATH"

	if brew --prefix coreutils > /dev/null 2>&1
	then
		export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
		export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
	fi
fi

export PATH="$HOME/.local/bin:$HOME/bin:$PATH:."
export MANPATH="$HOME/.local/man:$MANPATH"

eval "$(dircolors -b)"

