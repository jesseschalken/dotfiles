setlocal foldmethod=expr foldexpr=DiffFold(v:lnum)

let &l:foldlevel=&l:foldlevelstart

function! DiffFold(lnum)
    let line = getline(a:lnum)
    if line =~ '^\(diff\) '
        return '>1'
    elseif line =~ '^\(---\|+++\) '
        return '='
    elseif line =~ '^\(@@\) '
	    return '>2'
    elseif line[0] =~ '[-+ ]'
        return 2
    else
        return 1
    endif
endfunction

