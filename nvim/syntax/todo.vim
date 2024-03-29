if exists("b:current_syntax")
  finish
endif


" Tags can go anywhere in the task line

" projects: +foo, +foo/bar
syntax match todoProject "\v\+[a-zA-Z0-9\/._+-]+"

" ids: item:foo, :foo
syntax match todoIDFull "\vitem:[0-9a-f]{40}"
syntax match todoIDShort "\v:[0-9a-f]{2}"

" people: @person, person@, person@foo.com
syntax match todoPerson "\v\@[a-z0-9._+-]+"
syntax match todoPersonPostfix "\v[a-z0-9._+-]+\@([a-z0-9._-]+\a{2})?"

" channels: #foo
syntax match todoChannel "\v\#[a-zA-Z0-9._-]+"

" Jira tickets: FOO-123
syntax match todoJira "\v[A-Z]+\-[0-9]+"

" github links requests: squareup/java
syntax match todoGithub "\vsquareup\/[a-zA-Z0-9_-]+"

" pull requests: foo/bar#123
syntax match todoPR "\v[a-zA-Z0-9_-]+\/[a-zA-Z0-9_-]+\#[0-9]+"

" urls: https://...
syntax match todoURL "\v[a-zA-Z0-9_-]+://[a-zA-Z0-9?\.\/#%_+=-]+"

" urls: go/...
syntax match todoGo "\vgo/[a-zA-Z0-9\.\/#%_-]+"

" notes / lists: ~foo
syntax match todoNote "\v\~[a-zA-Z0-9._ -]+"

" magic lists: ~*foo
syntax match todoMagic "\v\~\*[a-zA-Z0-9._ -]+"

" Bullets must be the first non-space character on a line

" regular bullets: * task
syntax match todoBullet "\v^ *\*"

" question bullets: ? task
syntax match todoQuestion "\v^ *\?"

" waiting bullets: - task
syntax match todoWaiting "\v^ *\-"

" priority bullets: ! task, !! task, !!! task
syntax match todoUrgent "\v^ *\!"

" completed bullet: x task
syntax match todoDone "\v^ *x.*"

" skipped bullet: / task
syntax match todoSkip "\v^ *\/.*"


" Colors

hi todoIDFull ctermfg=0
hi link todoIDShort todoIDFull
hi todoProject ctermfg=14
hi todoContact ctermfg=2
hi link todoPerson todoContact
hi link todoPersonPostfix todoContact
hi link todoChannel todoContact
hi todoExternal ctermfg=3
hi link todoJira todoExternal
hi link todoPR todoExternal
hi todoURL ctermfg=6
hi link todoGo todoURL
hi link todoGithub todoURL
hi todoNote ctermfg=4
hi todoMagic ctermfg=12

hi todoDone ctermfg=7
hi todoSkip ctermfg=5
hi todoBullet ctermfg=7
hi todoQuestion ctermfg=13
hi todoWaiting ctermfg=3
hi todoUrgent ctermfg=1
