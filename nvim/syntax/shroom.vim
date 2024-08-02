if exists("b:current_syntax")
  finish
endif

syn keyword shroomEvent onChoice onPrepare onDiscard onModPower onModStamina onUseStamina onGather onPlay onSummon onDie onEmpty onStart onMorning onTurn onNight onFinish

syn keyword shroomKeyword if elif else return
syn keyword shroomKeyword has and or space

syn keyword shroomFunction activate event setPower setStamina setTraits modPower modStamina forceModPower forceModStamina useStamina summon

syn keyword shroomVariable critter area amount source played target discarded first second none trait from to name value credit at pow stam name

syn match shroomSymbol "\v\("
syn match shroomSymbol "\v\)"
syn match shroomSymbol "\v\{"
syn match shroomSymbol "\v\}"
syn match shroomSymbol "\v\="
syn match shroomSymbol "\v\."
syn match shroomSymbol "\v\,"
" syn match shroomSymbol "\v\:\="

syn match shroomOperator "\v\+"
syn match shroomOperator "\v\/"
syn match shroomOperator "\v\-"
syn match shroomOperator "\v\*"

syn region shroomString start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ keepend

syn match shroomNumber "\v\-?[0-9]+"

syn match shroomComment1 "#.*$" display
syn match shroomComment2 "\/\/.*$" display

" hi link shroomBad DiagnosticWarn
hi link shroomSymbol Operator
" hi link shroomOperator Operator
hi link shroomEvent Identifier
hi link shroomFunction Special
hi link shroomString String
hi link shroomNumber Number
hi link shroomVariable Operator
hi link shroomKeyword Keyword
hi link shroomComment1 Comment
hi link shroomComment2 Comment
" hi link shroomType Type
" hi link shroomGeneric Identifier
" PreProc
"  Boolean
"  String
"  Number
"  Number
"  Comment
" not used PreProc
