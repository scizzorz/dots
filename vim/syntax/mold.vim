if exists("b:current_syntax")
  finish
endif

syn keyword moldKeyword dir help if import recipe as require run var version
syn match moldKeyword "\v\$"

syn match moldSymbol "\v\("
syn match moldSymbol "\v\)"
syn match moldSymbol "\v\{"
syn match moldSymbol "\v\}"
syn match moldSymbol "\v\="

syn match moldOperator "\v\+"
syn match moldOperator "\v\|"
syn match moldOperator "\v\~"

syn match moldWild "\v\*"

syn region moldString start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ keepend

syn match moldComment1 "#.*$" display
syn match moldComment2 "\/\/.*$" display

hi link moldWild Special
hi link moldSymbol Operator
hi link moldOperator Identifier
hi link moldString String
hi link moldWild Boolean
hi link moldKeyword Keyword
hi link moldComment1 Comment
hi link moldComment2 Comment
" hi link moldType Type
" hi link moldGeneric Identifier
" PreProc
"  Boolean
"  String
"  Number
"  Number
"  Comment
" not used PreProc
