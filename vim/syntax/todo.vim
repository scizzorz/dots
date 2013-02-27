if exists("b:current_syntax")
	finish
endif

" Matches
syn match todoProject '\(^\|\s\)+[A-Za-z+]\+'
syn match todoContext '\(^\|\s\)@[A-Za-z+@]\+'
syn match todoPriority '\s*(\d)\s*'
syn match todoDue '\[\d\{1,2\}/\d\{1,2\}\(/\d\{2,4\}\)\=\([@ ]\d\{1,2\}\(:\d\{1,2\}\)\=\(am\|pm\)\)\=\]'

hi todoProject   ctermfg=9  ctermbg=none cterm=none
hi todoContext   ctermfg=2  ctermbg=none cterm=none
hi todoPriority  ctermfg=1  ctermbg=none cterm=none
hi todoDue       ctermfg=14 ctermbg=none cterm=none
