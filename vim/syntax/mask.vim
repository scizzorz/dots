if exists("b:current_syntax")
  finish
endif

syn keyword maskConvention this self new

syn keyword maskKeyword func class type impl enum
syn keyword maskKeyword if elif else
syn keyword maskKeyword loop while until for
syn keyword maskKeyword static
syn keyword maskKeyword print return

syn keyword maskType int float string bool seq array map

syn keyword maskResult result
syn keyword maskBoolean none true false

syn match   maskNumber "\<\d\>" display
syn match   maskNumber "\<[1-9]\d\+\>" display
syn match   maskNumber "\<\d\+[jJ]\>" display

syn match   maskFloat "\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>" display
syn match   maskFloat "\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
syn match   maskFloat "\<\d\+\.\d*\%([eE][+-]\=\d\+\)\=[jJ]\=" display

syn region  maskString start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ keepend
syn region  maskString start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ keepend

syn match   maskComment "#.*$" display

hi link maskConvention Special
hi link maskKeyword Keyword
hi link maskType Type
hi link maskBoolean Boolean
hi link maskString String
hi link maskResult Constant
hi link maskNumber Number
hi link maskFloat Number
hi link maskComment Comment
