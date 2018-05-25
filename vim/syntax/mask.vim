if exists("b:current_syntax")
  finish
endif

syn keyword maskPrelude print assert panic import

syn keyword maskStd core std math io mem

syn keyword maskKeyword pass local
syn keyword maskKeyword fn return
syn keyword maskKeyword catch
syn keyword maskKeyword if else
syn keyword maskKeyword for while loop break continue

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

" syn keyword maskType bool byte int float void unit str

syn keyword maskBoolean true false null table

syn match   maskNumber "\<\d\>" display
syn match   maskNumber "\<[1-9]\d\+\>" display
"syn match   maskNumber "\<\d\+[jJ]\>" display

syn match   maskFloat "\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>" display
"syn match   maskFloat "\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
"syn match   maskFloat "\<\d\+\.\d*\%([eE][+-]\=\d\+\)\=[jJ]\=" display

"syn region  maskString start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ keepend
syn region  maskString start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ keepend

syn match   maskComment "#.*$" display

hi link maskPrelude Special
hi link maskKeyOperator Operator
hi link maskOperator Operator
hi link maskKeyword Keyword
" hi link maskType Type
" hi link maskGeneric Identifier
hi link maskStd PreProc
hi link maskBoolean Boolean
hi link maskString String
hi link maskNumber Number
hi link maskFloat Number
hi link maskComment Comment
" not used PreProc
