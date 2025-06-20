if exists("b:current_syntax")
  finish
endif

syn keyword shroomEvent on_choice on_prepare on_discard on_mod_power on_mod_stamina on_use_stamina on_gather on_play on_summon on_summon_friend on_die on_empty on_start on_morning on_turn on_night on_finish

syn keyword shroomKeyword if elif else return
syn keyword shroomKeyword has and or space

syn keyword shroomFunction activate add_trait event force_mod_power force_mod_stamina mod_power mod_stamina prevent_action remove_trait set_name set_power set_stamina set_trait set_traits summon use_stamina gather force_use_stamina flag_removal

syn keyword shroomVariable amount area at count credit critter discarded first from name none other played pow second source stam summoned target to trait traits value can_act mushrooms

syn match shroomSymbol "\v\("
syn match shroomSymbol "\v\)"
syn match shroomSymbol "\v\{"
syn match shroomSymbol "\v\}"
syn match shroomSymbol "\v\="
syn match shroomSymbol "\v\<"
syn match shroomSymbol "\v\>"
syn match shroomSymbol "\v\!"
syn match shroomSymbol "\v\."
syn match shroomSymbol "\v\,"
" syn match shroomSymbol "\v\:\="

syn match shroomOperator "\v\+"
syn match shroomOperator "\v\/"
syn match shroomOperator "\v\-"
syn match shroomOperator "\v\*"
syn match shroomOperator "\v\%"

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
