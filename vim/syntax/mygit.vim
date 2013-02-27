if exists("b:current_syntax")
	finish
endif

syntax clear

" Matches
syn match gitDiffAdd '^+.*'
syn match gitDiffRm '^-.*'
syn match gitDiffRef '^\s.*'
syn match gitCommit '[a-f0-9]\{7,40\}'
syn match gitCommitLine 'commit [a-f0-9]\{40\}'
syn match gitAuthorLine 'Author:\s*.*'
syn match gitDateLine 'Date:\s*.*'

hi gitDiffAdd       ctermfg=2    ctermbg=none cterm=none
hi gitDiffRm        ctermfg=1    ctermbg=none cterm=none
hi gitDiffRef       ctermfg=8    ctermbg=none cterm=none

hi gitCommit        ctermfg=8    ctermbg=none cterm=none
hi gitCommitLine    ctermfg=8    ctermbg=none cterm=none
hi gitAuthorLine    ctermfg=9    ctermbg=none cterm=none
hi gitDateLine      ctermfg=14   ctermbg=none cterm=none
