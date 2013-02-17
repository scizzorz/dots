if exists("b:current_syntax")
	finish
endif

" Matches
syn match todoProject '\(^\|\s\)+[A-Za-z+]\+'
syn match todoContext '\(^\|\s\)@[A-Za-z+@]\+'
syn match todoPriority '\s*(\d)\s*'
" syn match todoDue ''

" hi def link todoDue Type
hi def link todoProject Constant
hi def link todoContext MatchParen
hi def link todoPriority Error
