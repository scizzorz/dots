if exists("b:current_syntax")
	finish
endif

" Keywords
syn keyword swimKeyword choice free stroke

" Matches
syn match swimSection '\[[a-zA-Z ]\+\]'
syn match swimReps '\d\+x\d\+'
syn match swimTime 'R\=\d*:\d\+'

hi def link swimKeyword Type
hi def link swimSection Title
hi def link swimTime PreProc
hi def link swimReps Constant
