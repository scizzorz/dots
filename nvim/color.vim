" largely yanked from my vim config without review
syntax on
syntax reset
hi clear

" non-syntax things
" Lines everywhere
hi CursorColumn ctermfg=none  ctermbg=0    cterm=none
hi ColorColumn  ctermfg=none  ctermbg=0    cterm=none
hi CursorLine   ctermfg=none  ctermbg=none cterm=none
hi CursorLineNr ctermfg=6     ctermbg=none cterm=none
hi VertSplit    ctermfg=0     ctermbg=0    cterm=none

hi SpellBad     ctermfg=1     ctermbg=0    cterm=None
hi SpellCap     ctermfg=4     ctermbg=0    cterm=None

hi MatchParen   ctermfg=9     ctermbg=none cterm=none

hi Visual       ctermfg=none  ctermbg=0    cterm=none

" Status line
hi StatusLine   ctermfg=6    ctermbg=0    cterm=none
hi StatusLineNC ctermfg=7     ctermbg=0    cterm=none

" Wild menu. Oh how I wish I could decouple you from the status line...
hi WildMenu     ctermfg=14    ctermbg=0    cterm=none

" Fold column
hi Folded       ctermfg=8    ctermbg=none cterm=none
hi FoldColumn   ctermfg=7    ctermbg=none cterm=none

" Autocomplete menu
hi Pmenu        ctermfg=7     ctermbg=0    cterm=none
hi PmenuSel     ctermfg=6     ctermbg=0    cterm=none
hi PmenuSbar    ctermfg=7     ctermbg=7    cterm=none
hi PmenuThumb   ctermfg=8     ctermbg=8    cterm=none

" messages
hi Error        ctermfg=1     ctermbg=none cterm=none
hi ErrorMsg     ctermfg=1     ctermbg=none cterm=none
hi ModeMsg      ctermfg=7     ctermbg=none cterm=none
hi MoreMsg      ctermfg=7     ctermbg=none cterm=none
hi WarningMsg   ctermfg=1     ctermbg=none cterm=none

" normal text
" This should also be decoupled from the stupid command line / statusline at the bottom
hi Normal       ctermfg=none  ctermbg=none cterm=none

" syntax formatting (line number, whitespace, etc.)
hi LineNr       ctermfg=8     ctermbg=none cterm=none
hi NonText      ctermfg=8     ctermbg=none cterm=none
hi SpecialKey   ctermfg=8     ctermbg=none cterm=none
hi WhitespaceEOL ctermfg=1    ctermbg=none cterm=none
hi Search       ctermfg=none  ctermbg=0    cterm=none
hi IncSearch    ctermfg=1     ctermbg=0    cterm=none
hi SignColumn   ctermfg=none  ctermbg=none cterm=none

" syntax TODO
hi Error        ctermfg=1     ctermbg=none cterm=none
hi Todo         ctermfg=4     ctermbg=none cterm=none
hi Identifier   ctermfg=11    ctermbg=none cterm=none
hi Type         ctermfg=3     ctermbg=none cterm=none
hi Constant     ctermfg=12    ctermbg=none cterm=none
hi String       ctermfg=10    ctermbg=none cterm=none
hi Comment      ctermfg=5     ctermbg=none cterm=none
hi Statement    ctermfg=6     ctermbg=none cterm=none
hi PreProc      ctermfg=9     ctermbg=none cterm=none
hi Special      ctermfg=14    ctermbg=none cterm=none
hi Underlined   ctermfg=15    ctermbg=none cterm=none
hi Ignore       ctermfg=15    ctermbg=none cterm=none
hi Operator     ctermfg=7     ctermbg=none cterm=none

" diff
hi DiffAdd     ctermfg=2      ctermbg=0    cterm=none
hi DiffChange  ctermfg=4      ctermbg=0    cterm=none
hi DiffDelete  ctermfg=1      ctermbg=0    cterm=none
hi DiffText    ctermfg=6      ctermbg=0    cterm=none

" rust
hi link rustModPath Identifier
hi link rustPubScope Identifier
hi link rustPubScopeDelim Operator
hi link rustQuestionMark Operator
hi link rustModPathSep Operator
hi link rustSelf Keyword
hi link rustSuper Keyword
hi link rustEnumVariant Special

" python
hi link pythonInclude Keyword

hi rustEscape ctermfg=2 ctermbg=none cterm=none
hi link rustLifetime rustEscape

" html / markdown
hi htmlH1     ctermfg=6   ctermbg=none  cterm=none
hi Title  ctermfg=6   ctermbg=none  cterm=none
hi htmlLink   ctermfg=3   ctermbg=none  cterm=none
hi htmlBold   ctermfg=4   ctermbg=none  cterm=none
hi mkdDelimiter ctermfg=7 ctermbg=none  cterm=none
hi mkdCode    ctermfg=15   ctermbg=0  cterm=none
hi link mkdCodeDelimiter mkdDelimiter
hi link mkdListItem mkdDelimiter
hi link mkdBold mkdDelimiter
hi link mkdBoldItalic mkdDelimiter
hi link mkdItalic mkdDelimiter
hi link mkdHeading mkdDelimiter
hi link rstEmphasis htmlBold
hi link rstStrongEmphasis htmlBold
hi link rstInlineLiteral mkdCode
hi link rstLiteralBlock mkdCode
hi link rstStandaloneHyperlink htmlLink
hi link rstFootnote htmlLink
hi link rstCitation htmlLink
hi link rstCitationReference htmlLink
hi link rstDelimiter mkdDelimiter
hi link htmlBoldUnderline htmlBold
hi link htmlBoldItalic htmlBold
hi link htmlBoldUnderlineItalic htmlBold
hi link htmlBoldItalicUnderline htmlBold
hi link htmlUnderlineBold htmlBold
hi link htmlUnderlineItalic htmlBold
hi link htmlUnderline htmlBold
hi link htmlUnderlineBoldItalic htmlBold
hi link htmlUnderlineItalicBold htmlBold
hi link htmlItalicBold htmlBold
hi link htmlItalicUnderline htmlBold
hi link htmlItalic htmlBold
hi link htmlItalicBoldUnderline htmlBold
hi link htmlItalicUnderlineBold htmlBold

" coc.nvim
hi CocErrorSign   ctermfg=1 ctermbg=8 cterm=none
hi CocHintSign    ctermfg=2 ctermbg=8 cterm=none
hi CocInfoSign    ctermfg=3 ctermbg=8 cterm=none
hi CocWarningSign ctermfg=4 ctermbg=8 cterm=none
hi CocUnderline   ctermbg=0

match WhitespaceEOL /\s\+$/
