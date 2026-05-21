" remap the leader key from \ to ,
let mapleader=","

" move within windows instead of using <C-W> as a prefix
noremap <silent> <C-H> <Esc>:wincmd h<CR>
noremap <silent> <C-J> <Esc>:wincmd j<CR>
noremap <silent> <C-K> <Esc>:wincmd k<CR>
noremap <silent> <C-L> <Esc>:wincmd l<CR>

" navigate between buffers
" noremap <silent> <C-M> <Esc>:bn<CR>
noremap <silent> <CR> <Esc>:bn<CR>
noremap <silent> <C-N> <Esc>:bp<CR>

" resize splits (it's confusing)
"noremap <silent> <C-I> <Esc>:res -1<CR>
"noremap <silent> <C-U> <Esc>:res +1<CR>
noremap <silent> <C-Y> <Esc>:vertical res -1<CR>

" suspend (normally <C-Z>)
nnoremap <silent> <C-D> <Esc>:stop<CR>

" shift between ALE chunks
nmap \ <cmd>lua vim.diagnostic.jump({ count = 1, float = true })<CR>
nmap \| <cmd>lua vim.diagnostic.jump({ count = -1, float = true })<CR>

" show syntax highlighting group of token under cursor
" https://stackoverflow.com/a/29030788
nnoremap <silent> <Leader>f :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
    \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
    \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
    \ . ">"<CR>

" sort the current paragraph
nnoremap <Leader>s vip:sort<CR>

" rehighlight syntax
nnoremap <Leader>r :syn sync fromstart<CR>

" run autoformattter (kinda bad tho)
nnoremap <Leader>b :!ruff format %<CR><CR>

" fix syntax highlighting (seriously how does it break so much?)
nnoremap <Leader>c :syn sync fromstart<CR>

" remove all trailing whitespace
nnoremap <Leader><Space> :%s/\s\+$//<CR><C-o>

" clear search
nnoremap <Leader>/ :let @/ = ""<CR>

" :Rg for project searching
noremap <C-g> <Esc>:Rg<CR>

" fzf / skim
noremap <C-f> <esc>:Files<CR>
noremap <C-o> <Esc>:Buffers<CR>
noremap <C-u> <Esc>:History<CR>


" save a modifier press
nnoremap ; :

" in visual mode, map ; to : without an automatic range, but let : still insert the range
vnoremap ; :<Backspace><Backspace><Backspace><Backspace><Backspace>

" auto indent the whole file
nnoremap = ggVG=<C-o><C-o>

" repeat last executed macro
nnoremap Q @@

" redo
nnoremap U <C-r>

" yank until the end of line, similar to S, D, and C
nnoremap Y y$

" toggles folds (za is awkward to press)
nnoremap zv za

" recursive fold toggling
nnoremap zV zA

" reselect visual block after indent / outdent
vnoremap < <gv
vnoremap > >gv

" extreme versions of hjkl
noremap H ^
noremap L $
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
