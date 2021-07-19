if exists("b:current_syntax")
  finish
endif


" Tags can go anywhere in the task line

" projects: +foo, +foo/bar
syntax match todoProject "\v\+[a-zA-Z0-9\/._+-]+"

" people: @person, person@, person@foo.com
syntax match todoPerson "\v\@[a-z0-9._+-]+"
syntax match todoPersonPostfix "\v[a-z0-9._+-]+\@([a-z0-9._-]+\a{2})?"

" channels: #foo
syntax match todoChannel "\v\#[a-zA-Z0-9._-]+"

" Jira tickets: FOO-123
syntax match todoJira "\v[A-Z]+\-[0-9]+"

" pull requests: foo/bar#123
syntax match todoPR "\v[a-zA-Z0-9_-]+\/[a-zA-Z0-9_-]+\#[0-9]+"


" Bullets must be the first non-space character on a line

" regular bullets: * task
syntax match todoBullet "\v^ *\*"

" question bullets: ? task
syntax match todoQ "\v^ *\?"

" priority bullets: ! task, !! task, !!! task
syntax match todoLow "\v^ *\!"
syntax match todoMed "\v^ *\!\!"
syntax match todoHigh "\v^ *\!\!\!"

" completed bullet: x task
syntax match todoDone "\v^ *x.*"

" skipped bullet: / task
syntax match todoSkip "\v^ *\/.*"


" Colors

hi todoProject ctermfg=14
hi todoContact ctermfg=2
hi link todoPerson todoContact
hi link todoPersonPostfix todoContact
hi link todoChannel todoContact
hi todoExternal ctermfg=3
hi link todoJira todoExternal
hi link todoPR todoExternal

hi todoDone ctermfg=7
hi todoSkip ctermfg=5
hi todoBullet ctermfg=7
hi todoQ ctermfg=13
hi todoLow ctermfg=4
hi todoMed ctermfg=12
hi todoHigh ctermfg=1
