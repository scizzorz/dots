set number
set scrolloff=4
set expandtab
set tabstop=2
set shiftwidth=2
set shiftround
set list
set listchars=tab:\|\ ,trail:·
set guicursor=
set mouse=a

set statusline=%F%(\ %m%)\ %(\ %r%)%(\ %h%)%=%{&ft}

set fillchars=stl:\ ,stlnc:\ ,vert:\ ,diff:\ ,fold:\  " no trailing whitespace here

set wildignore+=*.dll
set wildignore+=*.o
set wildignore+=*.pyc
set wildignore+=*.bak
set wildignore+=*.exe
set wildignore+=*.jpg
set wildignore+=*.jpeg
set wildignore+=*.png

set colorcolumn=88

" automatically resize splits when the window is resized
autocmd VimResized * exe "normal! \<c-w>="

filetype plugin indent on

source ~/.config/nvim/map.vim
source ~/.config/nvim/color.vim
source ~/.config/nvim/fold.vim

call plug#begin("~/.config/nvim/plugged")

Plug 'JulesWang/css.vim'
Plug 'cespare/vim-toml'
Plug 'hashivim/vim-terraform'
Plug 'justinj/vim-pico8-syntax'
Plug 'kshenoy/vim-signature'
Plug 'lotabout/skim.vim'
Plug 'mileszs/ack.vim'
Plug 'mitsuhiko/vim-jinja'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'niklasl/vim-rdf'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'pest-parser/pest.vim'
Plug 'plasticboy/vim-markdown'
Plug 'preservim/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-surround'
Plug 'xtfc/mold.vim'

call plug#end()

" coc.nvim config
" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-tab-or-custom-key-for-trigger-completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

nmap \ <Plug>(coc-diagnostic-next)
nmap \| <Plug>(coc-diagnostic-prev)

" NERDTree config
nmap <C-o> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
