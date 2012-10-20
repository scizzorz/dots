" settings
set nocp
set incsearch
set hlsearch
set ignorecase
set smartcase
set number
set cindent
set autoindent
set smartindent
set smarttab
set showmode
set showcmd
" set relativenumber
set undofile
set colorcolumn=100
set ts=4
set sw=4
set mouse=a
set encoding=utf-8
set list listchars=tab:»\ ,trail:·
set wmh=0
set wmw=0

" mappings
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W><Bar>
map <C-L> <C-W>l<C-W><Bar>
map <Tab> >
map <S-Tab> <
map <Enter> o<Esc>
inoremap jj <Esc>


" not sure
filetype indent on

" highlighting
set background=dark
set t_Co=256
let python_highlight_all = 1
let c_gnu = 1

syntax on
if exists("syntax_on")
  syntax reset
endif
hi clear

" dark grey
hi NonText		ctermfg=2		ctermbg=none		cterm=none
hi SpecialKey	ctermfg=2		ctermbg=none		cterm=none
hi LineNr		ctermfg=2		ctermbg=none		cterm=none
hi MatchParen	ctermfg=none	ctermbg=2			cterm=none
hi ColorColumn	ctermfg=none	ctermbg=0			cterm=none

" white
hi Normal		ctermfg=7		ctermbg=none		cterm=none

" red
hi Error 		ctermfg=8		ctermbg=none		cterm=none
hi Search		ctermfg=8		ctermbg=none		cterm=none

" orange
hi Special		ctermfg=9		ctermbg=none		cterm=none

" green
hi Constant		ctermfg=11		ctermbg=none		cterm=none

" cyan
hi PreProc		ctermfg=12		ctermbg=none		cterm=none

" blue
hi Underlined	ctermfg=13		ctermbg=none		cterm=none
hi Type			ctermfg=13		ctermbg=none		cterm=none
hi Identifier	ctermfg=13		ctermbg=none		cterm=none
hi Statement	ctermfg=13		ctermbg=none		cterm=none

" dark blue
hi Delimiter	ctermfg=14		ctermbg=none		cterm=none

" purple
hi Comment		ctermfg=15		ctermbg=none		cterm=none

au BufReadPost,FileReadPost *.js so ~/.vimrc-js
