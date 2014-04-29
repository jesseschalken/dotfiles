
function fish_prompt
    set_color -b white black
    echo -n $PWD | sed -e "s|^$HOME|~|"
    set_color -b normal normal
    echo -n ' '
    set_color -o -b blue blue
    echo -n 'λ'
    set_color -b normal normal
    echo -n ' '
end

function fish_right_prompt
    set_color -o black
    echo -s -n $USER '@' (hostname -s)
    set_color normal
end

