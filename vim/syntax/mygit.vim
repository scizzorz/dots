if exists("b:current_syntax")
	finish
endif

syntax clear

" Matches
syn match gitDiffAdd '^+.*'
syn match gitDiffRm '^-.*'
syn match gitDiffRef '^ .*'
syn match gitCommit '[a-f0-9]\{7,40\}'
syn match gitCommitLine 'commit [a-f0-9]\{40\}'
syn match gitAuthor '<[a-zA-Z]* [a-zA-Z ]*>$'
syn match gitAuthorLine 'Author:\s*.*'
syn match gitDate '(\d\+ \(hours\|minutes\|seconds\|days\|weeks\|years\|months\) ago)'
syn match gitDateLine 'Date:\s*.*'
syn match gitComment '^    .*'

hi gitDiffAdd       ctermfg=2  ctermbg=none cterm=none
hi gitDiffRm        ctermfg=1  ctermbg=none cterm=none
hi gitDiffRef       ctermfg=8  ctermbg=none cterm=none

hi gitCommit        ctermfg=1  ctermbg=none cterm=none
hi gitCommitLine    ctermfg=1  ctermbg=none cterm=none
hi gitAuthorLine    ctermfg=12 ctermbg=none cterm=none
hi gitAuthor        ctermfg=12 ctermbg=none cterm=none
hi gitDateLine      ctermfg=2  ctermbg=none cterm=none
hi gitDate          ctermfg=2  ctermbg=none cterm=none
hi gitComment       ctermfg=15 ctermbg=none cterm=none
