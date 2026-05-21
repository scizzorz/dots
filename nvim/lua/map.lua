vim.g.mapleader = ","

local map = vim.keymap.set

-- move within windows without <C-W> prefix
map('', '<C-H>', '<cmd>wincmd h<CR>', {silent = true})
map('', '<C-J>', '<cmd>wincmd j<CR>', {silent = true})
map('', '<C-K>', '<cmd>wincmd k<CR>', {silent = true})
map('', '<C-L>', '<cmd>wincmd l<CR>', {silent = true})

-- navigate between buffers
-- map('', '<C-M>', '<cmd>bn<CR>', {silent = true})
map('', '<CR>', '<cmd>bn<CR>', {silent = true})
map('', '<C-N>', '<cmd>bp<CR>', {silent = true})

-- resize splits
-- map('', '<C-I>', '<cmd>res -1<CR>', {silent = true})
-- map('', '<C-U>', '<cmd>res +1<CR>', {silent = true})
map('', '<C-Y>', '<cmd>vertical res -1<CR>', {silent = true})

-- suspend (normally <C-Z>)
map('n', '<C-D>', '<cmd>stop<CR>', {silent = true})

-- shift between diagnostic chunks
map('n', '\\', function() vim.diagnostic.jump({ count = 1, float = true }) end)
map('n', '\\|', function() vim.diagnostic.jump({ count = -1, float = true }) end)

-- show syntax highlighting group of token under cursor
map('n', '<Leader>f', '<cmd>Inspect<CR>', {silent = true})

-- sort the current paragraph
map('n', '<Leader>s', 'vip:sort<CR>')

-- rehighlight syntax
map('n', '<Leader>r', '<cmd>syn sync fromstart<CR>')

-- run autoformatter
map('n', '<Leader>b', ':!ruff format %<CR><CR>')

-- fix syntax highlighting
map('n', '<Leader>c', '<cmd>syn sync fromstart<CR>')

-- remove all trailing whitespace
map('n', '<Leader><Space>', ':%s/\\s\\+$//<CR><C-o>')

-- clear search
map('n', '<Leader>/', function() vim.fn.setreg('/', '') end)

-- :Rg for project searching
map('', '<C-g>', '<cmd>Rg<CR>')

-- fzf / skim
map('', '<C-f>', '<cmd>Files<CR>')
map('', '<C-o>', '<cmd>Buffers<CR>')
map('', '<C-u>', '<cmd>History<CR>')

-- save a modifier press
map('n', ';', ':')
-- in visual mode, strip the auto-inserted '<,'> range
map('v', ';', ':<Backspace><Backspace><Backspace><Backspace><Backspace>')

-- auto indent the whole file
map('n', '=', 'ggVG=<C-o><C-o>')

-- repeat last executed macro
map('n', 'Q', '@@')

-- redo
map('n', 'U', '<C-r>')

-- yank until end of line, like S, D, C
map('n', 'Y', 'y$')

-- toggle folds (za is awkward)
map('n', 'zv', 'za')
map('n', 'zV', 'zA')

-- reselect visual block after indent/outdent
map('v', '<', '<gv')
map('v', '>', '>gv')

-- extreme versions of hjkl
map('', 'H', '^')
map('', 'L', '$')
map('', 'K', '{')
map('', 'J', '}')

-- swap ' and ` (backtick behavior, apostrophe ergonomics)
map('', "'", '`')
map('', '`', "'")

-- disable command history window
map('n', 'q:', ':q')

-- typo fixes (no native Lua API for cabbrev)
vim.cmd([[
  cabbrev WQ wq
  cabbrev Wq wq
  cabbrev WQA wqa
  cabbrev WQa wqa
  cabbrev Wqa wqa
  cabbrev W w
  cabbrev Q q
  cabbrev Q! q!
  cabbrev weq wq
  cabbrev Weq wq
  cabbrev WEq wq
  cabbrev WEQ wq
  cabbrev qw wq
  cabbrev Qw wq
]])
