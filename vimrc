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
set scrolloff=4               " keep the cursor outside of the top/bottom 4 lines when scrolling
set backspace=indent,eol,start "let me backspace over this crap

if has("persistent_undo")
  set undodir=~/.vim/undo   " directory for undo files
  set undofile              " force vim to save undo history as a file
endif

set expandtab                 " use... spaces...
set tabstop=2                 " number of spaces that a tab counts for
set shiftwidth=2              " number of spaces to use for each step of (auto)indent
set shiftround                " always round indents to shiftwidth
silent! set mouse=a           " enable mouse if it exists
silent! set encoding=utf-8    " enable default encoding if it exists
set list                      " show tabs and EOL
set listchars=tab:\|\ ,trail:· " show tabs as right arrow quotes and trailing spaces as bullets
set winminheight=0            " the minimum height of a non-focused window
set winminwidth=0             " the minimum width of a non-focused window
set cursorline                " highlight the line with the cursor
set laststatus=2              " always show the status bar
set statusline=%F%(\ %m%)\ %{VisualPercent()}%(\ %r%)%(\ %h%)%=%{&ft}\  " useful statusline: full filepath [+] [31/250 1%] [RO] [Help]                 vim
set viewoptions=folds         " only save folds with views
set foldcolumn=0              " show a fold column!
set foldtext=FoldText()       " set the collapsed fold text
set foldmethod=indent         " set automatic folding
set foldignore=               " always fold everything based on indent; don't ignore comments
set fillchars=stl:\ ,stlnc:\ ,vert:\ ,fold:\ ,diff:\  " set all fillchars to space. these are used in things like fold text.
set wildmenu                  " enable the wild menu (EX command completion)
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*.class " ignore these extensions (courtesy of Armin Ronacher)
set nomagic                   " turn off magic in regexps
set cc=80                     " set a line at the 80th column
let mapleader=","             " remap the leader key from \ to ,
filetype indent on

" adapted from :help fold.txt
" displays the first line of the fold at the appropriate indentation
function! FoldText()
  let line = getline(v:foldstart)
  let stripped = substitute(line, '^\s*\(.\{-}\)\s*$', '\1', '')

  let dashes = v:folddashes
  let tabbed = substitute(dashes, '-', '  ', 'g')

  let line2 = getline(v:foldend)
  let stripped2 = substitute(line2, '^\s*\(.\{-}\)\s*$', '\1', '')

  let diff = v:foldend - v:foldstart

  return tabbed . stripped . ' + ' . diff . ' more'
endfunction

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
  autocmd BufRead * set foldignore=

  " automatically reload vimrc when it's saved
  autocmd BufWritePost vimrc,.vimrc so ~/.vimrc

  " automatically resize splits when the window is resized
  autocmd VimResized * exe "normal! \<c-w>="
endif

" mappings
" map <C-HJKL> to move within windows instead of <C-W><HJKL>
map <silent> <C-H> <Esc>:wincmd h<CR>
map <silent> <C-J> <Esc>:wincmd j<CR>
map <silent> <C-K> <Esc>:wincmd k<CR>
map <silent> <C-L> <Esc>:wincmd l<CR>

map <silent> <C-M> <Esc>:bn<CR>
map <silent> <C-N> <Esc>:bp<CR>

map <silent> <C-O> <Esc>:vertical res +1<CR>
map <silent> <C-I> <Esc>:res -1<CR>
map <silent> <C-U> <Esc>:res +1<CR>
map <silent> <C-Y> <Esc>:vertical res -1<CR>

" map <Leader>s to sort the current paragraph
nmap <Leader>s KjVJk:sort<CR>

" map <Leader><Space> to remove all whitespace
nmap <Leader><Space> :%s/\s\+$//<CR><C-o>

" map <Leader>m to run :!make
nmap <Leader>m :!make<CR>

" map <Leader>/ to clear search
nmap <Leader>/ :let @/ = ""<CR>

" map ; to :
nnoremap ; :

" in visual mode, map ; to : without an automatic range, but let : still insert the range
vnoremap ; :<Backspace><Backspace><Backspace><Backspace><Backspace>

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

" remap zV and zT to recursive toggling
nnoremap zV zA
nnoremap zT zA

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

" I hate it when K manpages, so I'll make it useful
map K {
map J }

" GET OUTTA TOWN, COMMAND HISTORY
nnoremap q: :q

" GET OUTTA TOWN, DEFAULT <CR>
nnoremap <CR> <nop>

" custom commands
" stupid shift key
cabbrev WQ wq
cabbrev Wq wq
cabbrev WQA wqa
cabbrev WQa wqa
cabbrev Wqa wqa
cabbrev W w
cabbrev Q q
cabbrev Q! q!
" stupid e key
cabbrev weq wq
cabbrev Weq wq
cabbrev WEq wq
cabbrev WEQ wq
" stupid backwards keys
cabbrev qw wq
cabbrev Qw wq

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
hi CursorLineNr ctermfg=6     ctermbg=none cterm=none
hi VertSplit    ctermfg=0     ctermbg=0    cterm=none

hi MatchParen   ctermfg=9     ctermbg=none cterm=none

hi Visual       ctermfg=none  ctermbg=0    cterm=none

" Status line
hi StatusLine   ctermfg=6    ctermbg=0    cterm=none
hi StatusLineNC ctermfg=7     ctermbg=0    cterm=none

" Wild menu. Oh how I wish I could decouple you from the status line...
hi WildMenu     ctermfg=9     ctermbg=0    cterm=none

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
hi Normal       ctermfg=15    ctermbg=none cterm=none

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
hi Todo         ctermfg=1     ctermbg=none cterm=none
hi Identifier   ctermfg=11    ctermbg=none cterm=none
hi Type         ctermfg=3     ctermbg=none cterm=none
hi Constant     ctermfg=12    ctermbg=none cterm=none
hi Comment      ctermfg=5     ctermbg=none cterm=none
hi Statement    ctermfg=6     ctermbg=none cterm=none
hi PreProc      ctermfg=9     ctermbg=none cterm=none
hi Special      ctermfg=14    ctermbg=none cterm=none
hi Underlined   ctermfg=15    ctermbg=none cterm=none
hi Ignore       ctermfg=15    ctermbg=none cterm=none

" diff
hi DiffAdd     ctermfg=2      ctermbg=0    cterm=none
hi DiffChange  ctermfg=4      ctermbg=0    cterm=none
hi DiffDelete  ctermfg=1      ctermbg=0    cterm=none
hi DiffText    ctermfg=6      ctermbg=0    cterm=none

match WhitespaceEOL /\s\+$/

execute pathogen#infect()
