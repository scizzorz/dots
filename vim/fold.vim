set foldcolumn=0              " show a fold column!
set foldtext=FoldText()       " set the collapsed fold text
set foldmethod=indent         " set automatic folding
set foldignore=               " always fold everything based on indent; don't ignore comments

" adapted from :help fold.txt
" displays the first line of the fold at the appropriate indentation
" this is a lame issue with indentations that aren't 2sp
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
