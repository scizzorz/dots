" set visual scroll bar to an ASCII char
let g:visualPagePercent_window_char = '*'

" turn on sign column with ale
let g:ale_sign_column_always=1
let g:ale_linters = {
      \  'python': ['flake8'],
      \}

" pathogen is a plugin to manage plugins
execute pathogen#infect()
