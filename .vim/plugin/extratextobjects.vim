" E = { } < > [ ] ( )
" S = , . / : ; + - * %
" 
" E    stuff stuff    S   stuff stuff    S   stuff stuff   E
"      ===========--------                                  
"                         ===========--------               
"                                    --------===========    
"
" E    stuff stuff    S   stuff stuff    S   stuff stuff     S    E
"      ===========--------                                  
"                         ===========--------               
"                                            ===========----------

" Returns whether or not there is a match for the given pattern at the given
" position.
function! s:is_pattern_at_pos(pattern, position)
	let oldposition = getpos('.') " copy the current position so we can restore it later

	call cursor(a:position)
	let nextoccourance = searchpos(a:pattern, 'nc')

	call setpos('.', oldposition) " restore the old position

	return a:position == nextoccourance
endfunction

" Selects the text in the given range, given by [[line, column], [line,
" column]] *including* the first character but *excluding* the last
"
" If either the start or ending positions are [0, 0] this function does
" nothing.
function! s:select_range(range)
	let start = a:range[0]
	let end = a:range[1]
	if start == [0,0] || end == [0,0]
		return
	endif

	normal! v
	call cursor(start)
	normal! o
	call cursor(end)

	" if we are in the first column
	if end[1] == 1
		" move up and to the end of the line
		normal! k$
	else
		" otherwise just move left 1 char
		normal! h
	endif
endfunction

" Returns the range in the format [[line, column], [line, column]] for the
" text object that should be selected given the current cursor position and
" the regular expressions 'start', 'middle' and 'end' which denote the head,
" body and tail of a list (like "[", ",", "]" for a list like "[a, b, c]").
" Set 'inner' to true if you do not want the nearest list seperator to be
" included in the selection.
function! s:get_object(start, middle, end, inner)

	" TODO: These should probably be reworked to use /zs and /ze instead of
	" lookaheads and lookbehinds, because lookarounds do not woek over
	" multiple lines. I can't figure it out, though, and this works fine as
	" long as a seperator does not span more than 2 lines.

	let start_of_middle = '\%(\_s*' . a:middle . '\_s*\)\@=\S\@<='
	let end_of_middle   = '\%(\_s*' . a:middle . '\_s*\)\@<=\S\@='

	let start_of_end    = '\%(\_s*' . a:end . '\)\@=\S\@<=\%(' . a:start . '\)\@<!\%(' . a:middle . '\)\@<!' . 
		\ '\|\%(' . a:end . '\)\@=\%(\' . a:middle . '\_s*\)\@<='
	let end_of_start    = '\%(' . a:start . '\_s*\)\@<=\S\@=\%(' . a:end . '\)\@!'

	let s_skip ='synIDattr(synID(line("."), col("."), 0), "name") ' .
		\ '=~?	"string\\|comment"'
	execute 'if' s_skip '| let s_skip = 0 | endif'

	let start = searchpairpos(end_of_start, end_of_middle, start_of_end, 'cWnb', s_skip)
	let end   = searchpairpos(end_of_start, a:inner ? start_of_middle : end_of_middle, start_of_end, 'Wn', s_skip)

	" if we dont have the seperator and the end of our selection range, but we
	" do at the start
	if !a:inner && end != [0,0] && !s:is_pattern_at_pos(end_of_middle, end)
		" set the start position to instead include the previous seperator
		let start = searchpairpos(end_of_start, start_of_middle, start_of_end, 'cWnb')
	endif

	return [start, end]
endfunction

" Selects the text object for a list using the given seperator. The head and
" tail will be any of [...] {...} or (...) depending on what is nearest.
function! s:select_list_object(list_seperator, inner)
	call s:select_range( s:get_object( '[({[]', a:list_seperator, '[]})]', a:inner ) )
endfunction

omap <silent> a,      :call <SID>select_list_object(',', 0)<CR>
omap <silent> i,      :call <SID>select_list_object(',', 1)<CR>
vmap <silent> a, <ESC>:call <SID>select_list_object(',', 0)<CR>
vmap <silent> i, <ESC>:call <SID>select_list_object(',', 1)<CR>

omap <silent> a;      :call <SID>select_list_object(';', 0)<CR>
omap <silent> i;      :call <SID>select_list_object(';', 1)<CR>
vmap <silent> a; <ESC>:call <SID>select_list_object(';', 0)<CR>
vmap <silent> i; <ESC>:call <SID>select_list_object(';', 1)<CR>

omap <silent> a/      :call <SID>select_list_object('/', 0)<CR>
omap <silent> i/      :call <SID>select_list_object('/', 1)<CR>
vmap <silent> a/ <ESC>:call <SID>select_list_object('/', 0)<CR>
vmap <silent> i/ <ESC>:call <SID>select_list_object('/', 1)<CR>

omap <silent> a:      :call <SID>select_list_object(':', 0)<CR>
omap <silent> i:      :call <SID>select_list_object(':', 1)<CR>
vmap <silent> a: <ESC>:call <SID>select_list_object(':', 0)<CR>
vmap <silent> i: <ESC>:call <SID>select_list_object(':', 1)<CR>

