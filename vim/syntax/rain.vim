if exists("b:current_syntax")
  finish
endif

syn keyword rainStdlib array core env except file iter process re string
syn keyword rainBuiltin main print exit panic

syn keyword rainKeyword as break catch continue else export for foreign from
syn keyword rainKeyword func if import in is let loop library link macro pass
syn keyword rainKeyword return save until while with

syn match   rainMacro  "@[a-zA-Z_][a-zA-Z0-9_]*\(\.[a-zA-Z_][a-zA-Z0-9_]*\)*"

syn match rainOperator "\v\("
syn match rainOperator "\v\)"
syn match rainOperator "\v\."
syn match rainOperator "\v\:"
syn match rainOperator "\v\="
syn match rainOperator "\v\["
syn match rainOperator "\v\]"

syn match rainOperator "\v\-\>"

syn match rainOperator "\v\=\>"
syn match rainOperator "\v\<\="
syn match rainOperator "\v\=\="
syn match rainOperator "\v\!\="
syn match rainOperator "\v\<"
syn match rainOperator "\v\>"

syn match rainOperator "\v\+"
syn match rainOperator "\v\-"
syn match rainOperator "\v\*"
syn match rainOperator "\v\/"

syn match rainOperator "\v\&"
syn match rainOperator "\v\|"
syn match rainOperator "\v\!"
syn match rainOperator "\v\$"
syn match rainOperator "\v\?"

syn keyword rainType bool cdata float int str func

syn keyword rainBoolean true false null table

syn match   rainNumber "\<\d\>" display
syn match   rainNumber "\<[1-9]\d\+\>" display

syn region  rainString start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ keepend

syn match   rainComment "#.*$" display

hi link rainStdlib Special
hi link rainBuiltin Identifier
hi link rainKeyOperator Operator
hi link rainOperator ModeMsg
hi link rainKeyword Keyword
hi link rainType Type
hi link rainMacro PreProc
hi link rainBoolean Boolean
hi link rainString String
hi link rainNumber Number
hi link rainFloat Number
hi link rainComment Comment
