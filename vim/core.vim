set nocompatible              " remove vi compatibility

set incsearch                 " show search matches as they're typed
set hlsearch                  " highlight all search matches
set ignorecase                " ignore case while searching
set smartcase                 " don't ignore case while searching IF I use a capital

set autoindent                " copy indent from current line when starting a new line
set smarttab                  " makes tabs/backspace more helpful at the beginning of lines

set number                    " show line numbers
set showmode                  " show the mode when in insert/replace/visual
set showcmd                   " show partial commands

set directory=~/.vim/swap     " directory for swap files
set scrolloff=4               " keep the cursor outside of the top/bottom 4 lines when scrolling
set backspace=indent,eol,start "let me backspace over this crap

set expandtab                 " use... spaces...
set tabstop=2                 " number of spaces that a tab counts for
set shiftwidth=2              " number of spaces to use for each step of (auto)indent
set shiftround                " always round indents to shiftwidth

silent! set mouse=a           " enable mouse if it exists
silent! set encoding=utf-8    " enable default encoding if it exists

set list                      " show tabs and EOL
set listchars=tab:\|\ ,trail:· " show tabs as pipes and trailing spaces as bullets

set winminheight=0            " the minimum height of a non-focused window
set winminwidth=0             " the minimum width of a non-focused window

set cursorline                " highlight the line with the cursor

set laststatus=2              " always show the status bar
set statusline=%F%(\ %m%)\ %{VisualPercent()}%(\ %r%)%(\ %h%)%=%{&ft}\  " statusline

set viewoptions=folds         " only save folds with views
set fillchars=stl:\ ,stlnc:\ ,vert:\ ,fold:\ ,diff:\  " set all fillchars to space. these are used in things like fold text.

set wildmenu                  " enable the wild menu (EX command completion)
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*.class " ignore these extensions (courtesy of Armin Ronacher)

set nomagic                   " turn off magic in regexps
set colorcolumn=88            " set a line at the 88th column

filetype indent on

if has("persistent_undo")
  set undodir=~/.vim/undo     " directory for undo files
  set undofile                " force vim to save undo history as a file
endif
