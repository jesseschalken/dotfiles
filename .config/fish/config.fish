set fish_color_normal normal
set fish_color_command --bold normal
set fish_color_quote --bold green
set fish_color_redirection --bold blue
set fish_color_end --bold blue
set fish_color_error --bold red
set fish_color_param normal
set fish_color_comment yellow --bold
set fish_color_match --bold blue
set fish_color_search_match --bold purple
set fish_color_operator blue --bold
set fish_color_escape blue --bold
set fish_color_cwd green --bold

set fish_color_cwd_root red --bold
set fish_color_autosuggestion 666
set fish_color_red red --bold
set fish_color_history_current blue --bold
set fish_color_valid_path --underline

set fish_pager_color_completion normal
set fish_pager_color_description 555
set fish_pager_color_prefix --bold
set fish_pager_color_progress cyan --bold

function fish_prompt
    set_color -b ccc 000
    echo -n $PWD | sed -e "s|^$HOME|~|"
    set_color -b normal normal
    echo -n ' '
    switch $USER
        case root
            set_color -o -b 900 f33
        case '*'
            set_color -o -b 00c 66f
    end
    echo -n 'λ'
    set_color -b normal normal
    echo -n ' '
end

function fish_right_prompt
    set_color 666
    echo -s -n $USER '@' (hostname -s)
    set_color normal
end

