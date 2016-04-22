if exists("b:current_syntax")
  finish
endif

syn keyword maskConvention this self result main init load

syn keyword maskLib core std math io mem

syn keyword maskKeyword print import
syn keyword maskKeyword if else
syn keyword maskKeyword for while until loop defer block
syn keyword maskKeyword pass break continue return
syn keyword maskKeyword trait bind struct type with
syn keyword maskKeyword match as when
syn keyword maskKeyword partial extern

syn keyword maskKeyOperator and or xor not
syn keyword maskKeyOperator in is to


syn match maskOperator "\v\("
syn match maskOperator "\v\)"
syn match maskOperator "\v\:"
syn match maskOperator "\v\="
syn match maskOperator "\v\["
syn match maskOperator "\v\]"
syn match maskOperator "\v\{"
syn match maskOperator "\v\}"

syn match maskOperator "\v\=\>"
syn match maskOperator "\v\<\="
syn match maskOperator "\v\-\>"
syn match maskOperator "\v\<\-"
syn match maskOperator "\v\&"
syn match maskOperator "\v\|"
syn match maskOperator "\v\^"
syn match maskOperator "\v\~"
syn match maskOperator "\v\$"
syn match maskOperator "\v\+"
syn match maskOperator "\v\-"
syn match maskOperator "\v\*"
syn match maskOperator "\v\/"
syn match maskOperator "\v\%"
syn match maskOperator "\v\<"
syn match maskOperator "\v\>"
syn match maskOperator "\v\=\="
syn match maskOperator "\v\!\="
syn match maskOperator "\v\."

syn keyword maskType bool byte int float void unit str
syn keyword maskType i1 i8 i16 i32 i64  f32 f64
syn keyword maskType ptr
syn keyword maskType func
syn match maskGeneric "\v\<\w+\>"

syn keyword maskBoolean true false

syn match   maskNumber "\<\d\>" display
syn match   maskNumber "\<[1-9]\d\+\>" display
"syn match   maskNumber "\<\d\+[jJ]\>" display

syn match   maskFloat "\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>" display
"syn match   maskFloat "\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
"syn match   maskFloat "\<\d\+\.\d*\%([eE][+-]\=\d\+\)\=[jJ]\=" display

"syn region  maskString start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ keepend
syn region  maskString start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ keepend

syn match   maskComment "#.*$" display

hi link maskConvention Special
hi link maskKeyOperator Operator
hi link maskOperator ModeMsg
hi link maskKeyword Keyword
hi link maskType Type
hi link maskGeneric Identifier
hi link maskLib PreProc
hi link maskBoolean Boolean
hi link maskString String
hi link maskNumber Number
hi link maskFloat Number
hi link maskComment Comment
" not used PreProc
