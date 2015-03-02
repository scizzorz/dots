if exists("b:current_syntax")
  finish
endif

syn keyword maskConvention this self new result

syn keyword maskKeyword func class trait impl enum
syn keyword maskKeyword pass break continue return
syn keyword maskKeyword if for while until loop elif else
syn keyword maskKeyword static
syn keyword maskKeyword print

syn keyword maskOperator as of is in
syn keyword maskOperator and or xor not

syn keyword maskType int float str bool seq array map

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
hi link maskOperator Operator
hi link maskKeyword Keyword
hi link maskType Type
hi link maskBoolean Boolean
hi link maskString String
hi link maskNumber Number
hi link maskFloat Number
hi link maskComment Comment
