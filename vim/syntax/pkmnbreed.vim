if exists("b:current_syntax")
	finish
endif

syn keyword pkmnStatPerfect 31
syn keyword pkmnStatFantastic 26 27 28 29 30
syn keyword pkmnStatGood 16 17 18 19 20 21 22 23 24 25
syn keyword pkmnStatDecent 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
syn keyword pkmnStatUnknown x

syn match pkmnMale 'm\*\?'
syn match pkmnFemale 'f\*\?'
syn match pkmnUnknown '?'

hi pkmnStatPerfect ctermfg=14 ctermbg=none
hi pkmnStatFantastic ctermfg=2 ctermbg=none
hi pkmnStatGood ctermfg=4 ctermbg=none
hi pkmnStatDecent ctermfg=9 ctermbg=none
hi pkmnStatUnknown ctermfg=8 ctermbg=none
hi pkmnMale ctermfg=6 ctermbg=none
hi pkmnFemale ctermfg=13 ctermbg=none
hi pkmnUnknown ctermfg=4 ctermbg=none

set ts=3 " set ts
set listchars=tab:\ \     " set listchars
silent! iunmap <Tab>
