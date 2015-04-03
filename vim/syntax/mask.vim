if exists("b:current_syntax")
  finish
endif

syn keyword maskConvention this result

syn keyword maskKeyword type embed import alias
syn keyword maskKeyword pass break continue return print
syn keyword maskKeyword if elif else for while until loop finally break
syn keyword maskKeyword func

syn keyword maskKeyOperator in is as to
syn keyword maskKeyOperator and or xor not

syn match maskOperator "\v\:"
syn match maskOperator "\v\="
syn match maskOperator "\v\."
syn match maskOperator "\v\-\>"
syn match maskOperator "\v\("
syn match maskOperator "\v\)"
syn match maskOperator "\v\["
syn match maskOperator "\v\]"
syn match maskOperator "\v\=\>"
syn match maskOperator "\v\&"
syn match maskOperator "\v\&\&"
syn match maskOperator "\v\|"
syn match maskOperator "\v\|\|"
syn match maskOperator "\v\^"
syn match maskOperator "\v>\>"
syn match maskOperator "\v\<\<"
syn match maskOperator "\v\$"
syn match maskOperator "\v\+"
syn match maskOperator "\v\-"
syn match maskOperator "\v\~"
syn match maskOperator "\v\*"
syn match maskOperator "\v\*\*"
syn match maskOperator "\v\/"
syn match maskOperator "\v\/\/"
syn match maskOperator "\v\%"
syn match maskOperator "\v\%\%"
syn match maskOperator "\v\<\="
syn match maskOperator "\v\<"
syn match maskOperator "\v\>\="
syn match maskOperator "\v\>"
syn match maskOperator "\v\=\="
syn match maskOperator "\v\!\="

syn keyword maskType self int float str bool seq array map
syn match maskGenType "\v\?\w+"

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
hi link maskKeyOperator Operator
hi link maskOperator ModeMsg
hi link maskKeyword Keyword
hi link maskType Type
hi link maskGenType Identifier
hi link maskBoolean Boolean
hi link maskString String
hi link maskNumber Number
hi link maskFloat Number
hi link maskComment Comment
