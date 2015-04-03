if exists("b:current_syntax")
  finish
endif

syn region  bnfString start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ keepend
syn region  bnfString start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ keepend

syn match   bnfComment "#.*$" display

syn match   bnfToken "\<[A-Z]\+\>" display

syn match   bnfOper "\v\+" display
syn match   bnfOper "\v\*" display
syn match   bnfOper "\v\?" display
syn match   bnfOper "\v\|" display
syn match   bnfOper "\v\=" display
syn match   bnfOper "\v\(" display
syn match   bnfOper "\v\)" display

hi link bnfOper MoreMsg
hi link bnfToken Special
hi link bnfString String
hi link bnfComment Comment

