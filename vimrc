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
set so=4                      " keep the cursor outside of the top/bottom 4 lines when scrolling

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
set laststatus=2              " always show the status bar
set viewoptions=folds         " only save folds with views
" let &colorcolumn=join(range(101,999),",")
silent! set colorcolumn=101
set foldcolumn=1              " show a fold column!
set foldmethod=manual         " manual folding
set foldtext=getline(v:foldstart) " set fold line to be just the consumed line
" set foldmethod=indent         " set automatic folding
" set relativenumber            " show line numbers relative to the current line
filetype indent on            " special indenting by filetype I think

" auto commands
if has("autocmd")
	" clear all autocommands
	autocmd!

	" jump to last position when reopening
	autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
				\| exe "normal! g'\"" | endif

	" automatically save and restore views (folds)
	" maps have to be made *after* restoring or else the new maps
	" mess with the loadview
	autocmd BufWrite ?* mkview
	autocmd BufRead ?* silent! loadview | nnoremap Z zd
	" | nnoremap z za | vnoremap z zf

	" automatically reload vimrc when it's saved
	autocmd BufWritePost vimrc,.vimrc so ~/.vimrc

	" automatically resize splits when the window is resized
	autocmd VimResized * exe "normal! \<c-w>="

	" update the title and stuff
	autocmd BufEnter * let &titlestring = $USER . " " . hostname(). " | vim " . expand("%:~:p")
	set title

	" I seriously hate q: more than anything in the whole world
	" but I can't do anything about it
	" if you know how to turn that off, PLEASE LET ME KNOW
endif

" mappings
" map <C-HJKL> to move within windows instead of <C-W><HJKL>
map <silent> <C-H> <Esc>:wincmd h<CR>
map <silent> <C-J> <Esc>:wincmd j<CR>
map <silent> <C-K> <Esc>:wincmd k<CR>
map <silent> <C-L> <Esc>:wincmd l<CR>

" map ; to :
nnoremap ; :
vmap ; :

" map : in visual to *just* a colon, dump the automatic range insertion
vnoremap : :<Backspace><Backspace><Backspace><Backspace><Backspace>

" remap = to auto indent the whole file
nnoremap = ggVG=<C-o><C-o>

" Q repeats last recorded macro
map Q @@

" U redoes
map U <C-r>

" Y yanks until the end of line
" makes it act like S, D, C
nmap Y y$

" zv and zt toggle folds (za is awkward to press)
nnoremap zv za
nnoremap zt za

" <j><j> in insert mode will simulate an escape
" (only useful on a non-full keyboard)
imap jj <Esc>

" reselect visual block after indent / outdent
vnoremap < <gv
vnoremap > >gv

" courtesy of Steve Losh
" map H and L to move all the way left and all the way right
noremap H ^
noremap L $

" http://vim.wikia.com/wiki/Autocomplete_with_TAB_when_typing_words
" Use tab to complete when typing words, else inserts tabs as usual.
function! TabOrComplete()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
		return "\<C-N>"
	else
		return "\<Tab>"
	endif
endfunction
inoremap <Tab> <C-R>=TabOrComplete()<CR>

" custom commands
" stupid shift key
cabbrev WQ wq
cabbrev Wq wq
cabbrev W w
cabbrev Q q
cabbrev Q! q!
" stupid e key
cabbrev weq wq
cabbrev Weq wq
cabbrev WEq wq
cabbrev WEQ wq


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

" non-syntax things
" Lines everywhere
hi CursorColumn ctermfg=none  ctermbg=0    cterm=none
hi ColorColumn  ctermfg=none  ctermbg=0    cterm=none
hi CursorLine   ctermfg=none  ctermbg=none cterm=none
hi CursorLineNr ctermfg=10    ctermbg=none cterm=none
hi VertSplit    ctermfg=0     ctermbg=0    cterm=none

hi MatchParen   ctermfg=2     ctermbg=none cterm=none

hi Visual       ctermfg=none  ctermbg=0    cterm=none

" Status line
hi StatusLine   ctermfg=10    ctermbg=0    cterm=none
hi StatusLineNC ctermfg=7     ctermbg=0    cterm=none

" Fold column
hi Folded       ctermfg=2     ctermbg=none cterm=none
hi FoldColumn   ctermfg=2     ctermbg=none cterm=none

" Autocomplete menu
hi Pmenu        ctermfg=7     ctermbg=0    cterm=none
hi PmenuSel     ctermfg=10    ctermbg=0    cterm=none

" messages
hi Error        ctermfg=1     ctermbg=none cterm=none
hi ErrorMsg     ctermfg=1     ctermbg=0    cterm=none
hi ModeMsg      ctermfg=4     ctermbg=0    cterm=none
hi MoreMsg      ctermfg=4     ctermbg=0    cterm=none
hi WarningMsg   ctermfg=1     ctermbg=0    cterm=none

" white
hi Normal       ctermfg=15    ctermbg=none cterm=none

" syntax formatting (line number, whitespace, etc.)
hi LineNr       ctermfg=8     ctermbg=none cterm=none
hi NonText      ctermfg=8     ctermbg=none cterm=none
hi SpecialKey   ctermfg=8     ctermbg=none cterm=none
hi WhitespaceEOL ctermfg=1    ctermbg=none cterm=none
hi Search       ctermfg=13    ctermbg=none cterm=none
hi IncSearch    ctermfg=13    ctermbg=0    cterm=none
hi SignColumn   ctermfg=none  ctermbg=none cterm=none

" syntax
hi Error        ctermfg=1     ctermbg=none cterm=none
hi Identifier   ctermfg=2     ctermbg=none cterm=none
hi Constant     ctermfg=4     ctermbg=none cterm=none
hi Type         ctermfg=6     ctermbg=none cterm=none
hi PreProc      ctermfg=9     ctermbg=none cterm=none
hi Comment      ctermfg=11    ctermbg=none cterm=none
hi Todo         ctermfg=12    ctermbg=none cterm=none
hi Special      ctermfg=13    ctermbg=none cterm=none
hi Statement    ctermfg=14    ctermbg=none cterm=none
hi Underlined   ctermfg=15    ctermbg=none cterm=none
hi Ignore       ctermfg=15    ctermbg=none cterm=none

" TODO might want these back
" hi Title        ctermfg=??   ctermbg=none cterm=none
" hi Underlined   ctermfg=??   ctermbg=none cterm=none

match WhitespaceEOL /\s\+$/
