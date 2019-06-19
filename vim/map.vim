let mapleader=","             " remap the leader key from \ to ,

" map <C-HJKL> to move within windows instead of <C-W><HJKL>
noremap <silent> <C-H> <Esc>:wincmd h<CR>
noremap <silent> <C-J> <Esc>:wincmd j<CR>
noremap <silent> <C-K> <Esc>:wincmd k<CR>
noremap <silent> <C-L> <Esc>:wincmd l<CR>

" map <C-NM> to navigate between buffers
noremap <silent> <C-M> <Esc>:bn<CR>
noremap <silent> <C-N> <Esc>:bp<CR>

" map <C-YUIO> to resize splits (it's confusing)
noremap <silent> <C-O> <Esc>:vertical res +1<CR>
noremap <silent> <C-I> <Esc>:res -1<CR>
noremap <silent> <C-U> <Esc>:res +1<CR>
noremap <silent> <C-Y> <Esc>:vertical res -1<CR>

" map <C-D> to suspend (normally <C-Z>)
nnoremap <silent> <C-D> <Esc>:stop<CR>

" map \ and | to shift between ALE chunks
nnoremap \ <Plug>(ale_next_wrap)
nnoremap \| <Plug>(ale_previous_wrap)

" map ,f to show syntax highlighting
" https://stackoverflow.com/a/29030788
nnoremap <silent> <Leader>f :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
    \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
    \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
    \ . ">"<CR>

" map <Leader>s to sort the current paragraph
nnoremap <Leader>s vip:sort<CR>

" map <Leader><Space> to remove all trailing whitespace
nnoremap <Leader><Space> :%s/\s\+$//<CR><C-o>

" map <Leader>m to run :!make
nnoremap <Leader>m :!make<CR>

" map <Leader>/ to clear search
nnoremap <Leader>/ :let @/ = ""<CR>

" map to :Rg for project searching
nnoremap <C-g> :Rg<CR>

" map  to use fzf
nnoremap <C-f> :Files<CR>

" map ; to : - save a key
nnoremap ; :

" in visual mode, map ; to : without an automatic range, but let : still insert the range
vnoremap ; :<Backspace><Backspace><Backspace><Backspace><Backspace>

" remap = to auto indent the whole file
nnoremap = ggVG=<C-o><C-o>

" Q repeats last recorded macro
nnoremap Q @@

" U redoes
nnoremap U <C-r>

" Y yanks until the end of line
" makes it act like S, D, C
nnoremap Y y$

" zv toggles folds (za is awkward to press)
nnoremap zv za

" zV does recursive toggling
nnoremap zV zA

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
noremap K {
noremap J }

" swap ' and ` - apostrophe is easier to hit, but I prefer backtick's behavior
noremap ' `
noremap ` '

" GET OUTTA TOWN, COMMAND HISTORY
nnoremap q: :q

" typo fixes
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
