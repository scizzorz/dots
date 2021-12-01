if exists("b:current_syntax")
  finish
endif


" projects: +foo, +foo/bar
syntax match noteProject "\v\+[a-zA-Z0-9\/._+-]+"

" people: @person, person@, person@foo.com
syntax match notePerson "\v\@[a-z0-9._+-]+"
syntax match notePersonPostfix "\v[a-z0-9._+-]+\@([a-z0-9._-]+\a{2})?"

" channels: #foo
syntax match noteChannel "\v\#[a-zA-Z0-9._-]+"

" Jira tickets: FOO-123
syntax match noteJira "\v[A-Z]+\-[0-9]+"

" pull requests: foo/bar#123
syntax match notePR "\v[a-zA-Z0-9_-]+\/[a-zA-Z0-9_-]+\#[0-9]+"

" urls: https://...
syntax match noteURL "\v[a-zA-Z0-9_-]+://[a-zA-Z0-9\.\/\?#%_=-]+"

" urls: go/...
syntax match noteGo "\vgo/[a-zA-Z0-9\.\/#%_-]+"

" github links requests: squareup/java
syntax match noteGithub "\vsquareup\/[a-zA-Z0-9_-]+"

" notes: ~foo
syntax match noteNote "\v\~[a-zA-Z0-9._-]+"

" code: `foo`
syntax match noteCode "\v`.{-}`"


" regular bullets: * task
syntax match noteBullet "\v^ *\*"

" question bullets: ? note
syntax match noteQ "\v^ *\?"

" priority bullets: ! note, !! note, !!! note
syntax match noteLow "\v^\!"
syntax match noteMed "\v^\!\!"
syntax match noteHigh "\v^\!\!\!"

" skipped bullet: / note
syntax match noteComment "\v^\/.*"

" headers: # note, ## note, ### note
syntax match noteH1 "\v^\#.*"
syntax match noteH2 "\v^\#\#.*"
syntax match noteH3 "\v^\#\#\#.*"


" Colors

hi noteProject ctermfg=14
hi noteContact ctermfg=2
hi link notePerson noteContact
hi link notePersonPostfix noteContact
hi link noteChannel noteContact
hi noteExternal ctermfg=3
hi link noteJira noteExternal
hi link notePR noteExternal
hi noteURL ctermfg=6
hi link noteGo noteURL
hi link noteGithub noteURL
hi noteNote ctermfg=4
hi noteCode ctermfg=7

hi noteH1 ctermfg=11
hi noteH2 ctermfg=3
hi noteH3 ctermfg=6

hi noteBullet ctermfg=7
hi noteComment ctermfg=5
hi noteQ ctermfg=13
hi noteLow ctermfg=4
hi noteMed ctermfg=12
hi noteHigh ctermfg=1
