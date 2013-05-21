if exists("b:current_syntax")
	finish
endif

" Matches
syn match todoPlus '\(^\|\s\)+[A-Za-z0-9/]\+'
syn match todoAt '\(^\|\s\)@[A-Za-z0-9/]\+'
syn match todoHash '\(^\|\s\)#[A-Za-z0-9/]\+'
syn match todoPriority '\(^\|\s\)!\d'
syn match todoDue '\[\=\d\{1,2\}/\d\{1,2\}\(/\d\{2,4\}\)\=\([@ ]\d\{1,2\}\(:\d\{1,2\}\)\=\(am\|pm\)\)\=\]\='

hi todoPlus      ctermfg=12 ctermbg=none cterm=none
hi todoAt        ctermfg=2  ctermbg=none cterm=none
hi todoHash      ctermfg=14 ctermbg=none cterm=none
hi todoPriority  ctermfg=1  ctermbg=none cterm=none
hi todoDue       ctermfg=6  ctermbg=none cterm=none
