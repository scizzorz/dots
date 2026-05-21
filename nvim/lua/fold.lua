vim.opt.foldcolumn  = '0'
vim.opt.foldmethod  = 'indent'
vim.opt.foldignore  = ''

-- displays the first line of the fold at the appropriate indentation
-- adapted from :help fold.txt
local function fold_text()
  local line     = vim.fn.getline(vim.v.foldstart)
  local stripped = line:match('^%s*(.-)%s*$')

  local dashes = vim.v.folddashes
  local tabbed = dashes:gsub('-', string.rep(' ', vim.fn.shiftwidth()))

  local diff = vim.v.foldend - vim.v.foldstart

  return tabbed .. stripped .. ' + ' .. diff .. ' more'
end

_G.FoldText = fold_text
vim.opt.foldtext = 'v:lua.FoldText()'
