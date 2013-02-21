if exists("b:current_syntax")
	finish
endif

" Matches
syn match todoProject '\(^\|\s\)+[A-Za-z+]\+'
syn match todoContext '\(^\|\s\)@[A-Za-z+@]\+'
syn match todoPriority '\s*(\d)\s*'
syn match todoDue '\[\d\{1,2\}/\d\{1,2\}\(/\d\{2,4\}\)\=\([@ ]\d\{1,2\}\(:\d\{1,2\}\)\=\(am\|pm\)\)\=\]'

hi def link todoProject Constant
hi def link todoContext MatchParen
hi def link todoPriority Error
hi def link todoDue Type
