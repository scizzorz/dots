" clear all autocommands
autocmd!

" jump to last position when reopening
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif

" automatically reload vimrc when it's saved
autocmd BufWritePost vimrc,.vimrc so ~/.vimrc

" automatically resize splits when the window is resized
autocmd VimResized * exe "normal! \<c-w>="

" stupid Vim remembering where I was in the git commit file
autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
