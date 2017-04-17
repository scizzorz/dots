if exists("b:current_syntax")
  finish
endif

syn keyword rainBase array dict file iter macros process rand re string
syn keyword rainBase ast ops str int float bool

syn keyword rainCore print exit panic type to_str tostr length meta
syn keyword rainCore env except types gensym

syn keyword rainConv self main init new

" str int float bool

syn keyword rainKeyword as break catch continue else export for foreign from
syn keyword rainKeyword func if import in var loop library link macro pass
syn keyword rainKeyword return save until while with

syn match   rainMacro  "@[a-zA-Z_][a-zA-Z0-9_]*\(\.[a-zA-Z_][a-zA-Z0-9_]*\)*"
syn keyword rainMacro compound expr args params block argblock stmt
syn keyword rainMacro name namestr

syn match   rainOp "\v\."
syn match   rainOp "\v\:"
syn match   rainOp "\v\="
syn match   rainOp "\v\["
syn match   rainOp "\v\]"
syn match   rainOp "\v\{"
syn match   rainOp "\v\}"
syn match   rainOp "\v\("
syn match   rainOp "\v\)"

syn match   rainOp "\v\-\>"
syn match   rainOp "\v\:\:"

syn match   rainOp "\v\=\>"
syn match   rainOp "\v\<\="
syn match   rainOp "\v\=\="
syn match   rainOp "\v\!\="
syn match   rainOp "\v\<"
syn match   rainOp "\v\>"

syn match   rainOp "\v\+"
syn match   rainOp "\v\-"
syn match   rainOp "\v\*"
syn match   rainOp "\v\/"

syn match   rainOp "\v\&"
syn match   rainOp "\v\|"
syn match   rainOp "\v\!"
syn match   rainOp "\v\$"
syn match   rainOp "\v\?"

syn keyword rainType func

syn keyword rainBoolean true false null table

syn match   rainNumber "\<\d\>" display
syn match   rainNumber "\<[1-9]\d\+\>" display

syn region  rainString start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ keepend

syn match   rainComment "#.*$" display

hi link rainBase Question
hi link rainCore Identifier
hi link rainConv Special
hi link rainOp   ModeMsg
hi link rainKeyword Keyword
hi link rainType Type
hi link rainMacro PreProc
hi link rainBoolean Boolean
hi link rainString String
hi link rainNumber Number
hi link rainFloat Number
hi link rainComment Comment
