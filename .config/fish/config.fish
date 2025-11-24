if status --is-login
  fenv source ~/.profile
end

set -g async_prompt_functions _pure_prompt_git
set -g pure_enable_single_line_prompt true

alias bell="echo -ne '\a'"

