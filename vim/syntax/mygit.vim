if exists("b:current_syntax")
	finish
endif

syntax clear

" Matches
syn match gitDiffAdd '^+.*'
syn match gitDiffRm '^-.*'
syn match gitDiffRef '^\s.*'

hi gitDiffAdd       ctermfg=2    ctermbg=none cterm=none
hi gitDiffRm        ctermfg=1    ctermbg=none cterm=none
hi gitDiffRef       ctermfg=8    ctermbg=none cterm=none
