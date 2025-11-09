if status --is-login
  fenv source ~/.profile
end

set -g async_prompt_functions _pure_prompt_git

alias bell="echo -ne '\a'"

