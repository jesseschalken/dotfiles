setlocal foldmethod=expr foldexpr=DiffFold(v:lnum)

function! DiffFold(lnum)
    let line = getline(a:lnum)
    if line =~ '^\(diff\) '
        return '>1'
	elseif line =~ '^\(---\|+++\|index\|rename\|similarity\) '
        return 1
    elseif line =~ '^\(@@\) '
	    return '>2'
    elseif line[0] =~ '[-+ ]'
        return 2
    else
        return 0
    endif
endfunction
