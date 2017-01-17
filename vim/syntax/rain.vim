if exists("b:current_syntax")
  finish
endif

syn keyword rainConvention main

syn keyword rainKeyword as break continue else extern for from if
syn keyword rainKeyword import in is let loop pass print return save
syn keyword rainKeyword until while

syn match rainOperator "\v\("
syn match rainOperator "\v\)"
syn match rainOperator "\v\."
syn match rainOperator "\v\:"
syn match rainOperator "\v\="
syn match rainOperator "\v\["
syn match rainOperator "\v\]"
"syn match rainOperator "\v\{"
"yn match rainOperator "\v\}"

syn match rainOperator "\v\=\>"
syn match rainOperator "\v\<\="
syn match rainOperator "\v\-\>"
syn match rainOperator "\v\<\-"
syn match rainOperator "\v\&"
syn match rainOperator "\v\|"
"syn match rainOperator "\v\^"
"syn match rainOperator "\v\~"
"syn match rainOperator "\v\$"
syn match rainOperator "\v\+"
syn match rainOperator "\v\-"
syn match rainOperator "\v\*"
syn match rainOperator "\v\/"
"syn match rainOperator "\v\%"
syn match rainOperator "\v\<"
syn match rainOperator "\v\>"
syn match rainOperator "\v\=\="
syn match rainOperator "\v\!\="

syn keyword rainType bool data float int str func

syn keyword rainBoolean true false null table

syn match   rainNumber "\<\d\>" display
syn match   rainNumber "\<[1-9]\d\+\>" display

syn region  rainString start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ keepend

syn match   rainComment "#.*$" display

hi link rainConvention Special
hi link rainKeyOperator Operator
hi link rainOperator ModeMsg
hi link rainKeyword Keyword
hi link rainType Type
hi link rainGeneric Identifier
hi link rainLib PreProc
hi link rainBoolean Boolean
hi link rainString String
hi link rainNumber Number
hi link rainFloat Number
hi link rainComment Comment
