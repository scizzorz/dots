if exists("b:current_syntax")
  finish
endif

set textwidth=90
set cc=91

syntax match reviewBlank "\v^.*$" contained nextgroup=reviewContent skipnl

" no idea if this is correct but
syntax match reviewOverflow ".*" contained
syntax match reviewContent "^.*\%<91v." nextgroup=reviewOverflow

" any text in the header
syntax match reviewFreeHeader "\v.*" contained

" review levels
syntax match reviewBad "\vbad" contained
syntax match reviewOkay "\vokay" contained
syntax match reviewGood "\vgood" contained
syntax match reviewGreat "\vgreat" contained

" urls: https://...
syntax match reviewURL "\v[a-zA-Z0-9_-]+://[a-zA-Z0-9\.\/\?#%_=-]+" contained

" money: $...
syntax match reviewMoney "\v\$\d+(\.\d\d)?" contained

syntax match reviewKeyword "\v^[a-zA-Z0-9 ]+" contained nextgroup=reviewColon
syntax match reviewColon ": " contained nextgroup=reviewBad,reviewOkay,reviewGood,reviewGreat,reviewURL,reviewMoney,reviewFreeHeader
syntax match reviewHeader "\v^\w+: .*$" contains=reviewKeyword,reviewColon nextgroup=reviewHeader,reviewBlank skipnl


" Colors

hi reviewURL ctermfg=6
hi reviewMoney ctermfg=12
hi reviewKeyword ctermfg=3
hi reviewColon ctermfg=7
hi reviewBlank ctermfg=1

hi reviewFreeHeader ctermfg=7
hi reviewGood ctermfg=10
hi reviewOkay ctermfg=4
hi reviewBad ctermfg=1
hi reviewGreat ctermfg=2

hi reviewContent ctermfg=7
hi link reviewOverflow reviewBlank
