export EDITOR='nvim'
export CLICOLOR='1'
export LESS='-+X -~FSRx4'
export PAGER='less'
export LSCOLORS='ExFxCxDxBxegedabagacad'

export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export MANPATH="$HOME/.local/man:$MANPATH"

export GIT_MERGE_AUTOEDIT='no'

command -v dircolors >/dev/null && eval "$(dircolors -b)"
command -v gdircolors >/dev/null && eval "$(gdircolors -b)"

. "$HOME/.cargo/env"
