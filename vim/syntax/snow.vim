if exists("b:current_syntax")
  finish
endif

syn keyword snowBase file iter macros process rand re string
syn keyword snowBase ast ops
syn keyword snowCore print exit panic type to_str tostr length meta
syn keyword snowCore env except types
syn keyword snowConv self main init

syn keyword snowKeyword include decl func struct cast save addr load return if while var size

syn match   snowOp "\v\."
syn match   snowOp "\v\:"
syn match   snowOp "\v\="
syn match   snowOp "\v\["
syn match   snowOp "\v\]"
syn match   snowOp "\v\{"
syn match   snowOp "\v\}"
syn match   snowOp "\v\("
syn match   snowOp "\v\)"

syn match   snowOp "\v\-\>"
syn match   snowOp "\v\:\:"

syn match   snowOp "\v\=\>"
syn match   snowOp "\v\<\="
syn match   snowOp "\v\=\="
syn match   snowOp "\v\!\="
syn match   snowOp "\v\<"
syn match   snowOp "\v\>"

syn match   snowOp "\v\+"
syn match   snowOp "\v\-"
syn match   snowOp "\v\*"
syn match   snowOp "\v\/"

syn match   snowOp "\v\&"
syn match   snowOp "\v\|"
syn match   snowOp "\v\!"
syn match   snowOp "\v\$"
syn match   snowOp "\v\?"

syn keyword snowType bool i1 i8 i16 i32 i64 f32 f64 void

syn keyword snowBoolean true false null

syn match   snowNumber "\<\d\>" display
syn match   snowNumber "\<[1-9]\d\+\>" display

syn region  snowString start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ keepend

syn match   snowComment "#.*$" display

"hi link snowBase Question
"hi link snowCore Identifier
hi link snowConv Special
hi link snowOp   ModeMsg
hi link snowKeyword Keyword
hi link snowType Type
"hi link snowMacro PreProc
hi link snowBoolean Boolean
hi link snowString String
hi link snowNumber Number
hi link snowFloat Number
hi link snowComment Comment
