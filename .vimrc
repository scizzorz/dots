" settings
set nocompatible              " remove vi compatibility
set incsearch                 " show search matches as they're typed
set hlsearch                  " highlight all search matches
set ignorecase                " ignore case while searching
set smartcase                 " don't ignore case while searching IF I use a capital
set number                    " show line numbers
set cindent                   " automatic C-style indenting
set autoindent                " copy indent from current line when starting a new line
set smarttab                  " makes tabs/backspace more helpful at the beginning of lines
set showmode                  " show the mode when in insert/replace/visual
set showcmd                   " show partial commands
set directory=~/.vim/swap     " directory for swap files

if has("persistent_undo")
	set undodir=~/.vim/undo   " directory for undo files
	set undofile              " force vim to save undo history as a file
endif

set tabstop=4                 " number of spaces that a tab counts for
set shiftwidth=4              " number of spaces to use for each step of (auto)indent
silent! set mouse=a           " enable mouse if it exists
silent! set encoding=utf-8    " enable default encoding if it exists
set list                      " show tabs and EOL
set listchars=tab:»\ ,trail:· " show tabs as right arrow quotes and trailing spaces as bullets
set winminheight=0            " the minimum height of a non-focused window
set winminwidth=0             " the minimum width of a non-focused window
set cursorline                " highlight the line with the cursor
" set relativenumber          " show line numbers relative to the current line

" jump to last position when reopening
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
	\| exe "normal! g'\"" | endif
endif

" mappings
" map <C-HJKL> to move within windows instead of <C-W><HJKL>
nmap <silent> <C-H> <Esc>:wincmd h<CR>
nmap <silent> <C-J> <Esc>:wincmd j<CR>
nmap <silent> <C-K> <Esc>:wincmd k<CR>
nmap <silent> <C-L> <Esc>:wincmd l<CR>

" map <Tab> and <S-Tab> to < and > respectively
map <Tab> >
map <S-Tab> <

" enter in normal mode makes a new line
map <Enter> o<Esc>

" <j><j> in insert mode will simulate an escape
inoremap jj <Esc>

" rebound caps lock for autocompletion
inoremap <End> <C-P>

" custom commands

" stupid shift key
cabbrev WQ wq
cabbrev Wq wq
cabbrev W w
cabbrev Q q
cabbrev Q! q!

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

" super dark grey
hi ColorColumn	ctermfg=none	ctermbg=0			cterm=none

" dark grey
hi NonText		ctermfg=2		ctermbg=none		cterm=none
hi SpecialKey	ctermfg=2		ctermbg=none		cterm=none
hi LineNr		ctermfg=2		ctermbg=none		cterm=none
hi MatchParen	ctermfg=none	ctermbg=2			cterm=none
hi CursorLine	ctermfg=none	ctermbg=none		cterm=none

" white
hi Normal		ctermfg=7		ctermbg=none		cterm=none

" red
hi Error 		ctermfg=8		ctermbg=none		cterm=none
hi Search		ctermfg=8		ctermbg=none		cterm=none

" orange
hi Constant		ctermfg=9		ctermbg=none		cterm=none

" yellow

" green

" greenblue
hi PreProc		ctermfg=12		ctermbg=none		cterm=none
hi CursorLineNr	ctermfg=12		ctermbg=none		cterm=none

" cyan
hi Special		ctermfg=13		ctermbg=none		cterm=none
hi Delimeter	ctermfg=13		ctermbg=none		cterm=none

" blue
hi Underlined	ctermfg=14		ctermbg=none		cterm=none
hi Type			ctermfg=14		ctermbg=none		cterm=none
hi Statement	ctermfg=14		ctermbg=none		cterm=none
hi Identifier	ctermfg=14		ctermbg=none		cterm=none

" purple
hi Comment		ctermfg=15		ctermbg=none		cterm=none
