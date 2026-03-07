if exists("b:current_syntax")
  finish
endif

syn match junkSymbol "\v\{"
syn match junkSymbol "\v\}"
syn match junkSymbol "\v\["
syn match junkSymbol "\v\]"
syn match junkSymbol "\v\,"
syn match junkSymbol "\v\:"

syn match junkIdent "\v\#[a-zA-Z0-9\._-]+"
syn match junkName "\v[a-zA-Z0-9\._-]+"

syn match junkComment "\/\/.*$" display

syn match junkNumber "\v\-?[0-9]+(\.[0-9]+)?"

syn keyword junkBool true false

syn region junkString start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ keepend

" Colors

hi link junkBool Boolean
hi link junkComment Comment
hi link junkIdent Identifier
hi link junkNumber Number
hi link junkString String
hi link junkSymbol Operator
hi link junkIdent Type
hi link junkName Keyword
