if exists("b:current_syntax")
  finish
endif

syntax match todoProject "\v\+[a-zA-Z0-9\-\_\/]+"
syntax match todoPerson "\v\@[a-zA-Z0-9\-\_]+"
syntax match todoTag "\v\#[a-zA-Z0-9]+"
syntax match todoJira "\v[A-Z]+\-[0-9]+"
syntax match todoPR "\v[a-zA-Z0-9\-\_]+\/[a-zA-Z0-9\-\_]+\#[0-9]+"

syntax match todoBullet "\v^ *\*"
syntax match todoQ "\v^ *\?"
syntax match todoLow "\v^ *\!"
syntax match todoMed "\v^ *\!\!"
syntax match todoHigh "\v^ *\!\!\!"
syntax match todoDone "\v^ *x.*"

hi todoProject ctermfg=10
hi todoPerson ctermfg=2
hi todoExternal ctermfg=3
hi link todoJira todoExternal
hi link todoPR todoExternal

hi todoDone ctermfg=7
hi todoBullet ctermfg=7
hi todoQ ctermfg=13
hi todoTag ctermfg=11
hi todoLow ctermfg=4
hi todoMed ctermfg=12
hi todoHigh ctermfg=1
