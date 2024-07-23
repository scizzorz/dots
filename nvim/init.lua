vim.opt.number = true
vim.opt.scrolloff = 4
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.list = true
vim.opt.listchars = {tab = "| ", trail="·"}
vim.opt.guicursor = ""
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.statusline = "%F%( %m%) %( %r%)%( %h%)%=%{&ft}"
vim.opt.fillchars = {stl = " ", stlnc = " ", vert = " ", diff = " ", fold = " "}

vim.opt.wildignore = {
  "*.dll",
  "*.o",
  "*.pyc",
  "*.bak",
  "*.exe",
  "*.jpg",
  "*.jpeg",
  "*.png",
  "*.gif",
}

vim.opt.colorcolumn = "100"

vim.api.nvim_create_autocmd({"VimResized"}, {pattern = {"*"}, command = 'exe "normal! \\<c-w>="'})

vim.cmd("source ~/.config/nvim/map.vim")
vim.cmd("source ~/.config/nvim/color.vim")
vim.cmd("source ~/.config/nvim/fold.vim")

local plug = vim.fn["plug#"]
vim.fn["plug#begin"]("~/.config/nvim/plugged")

plug('JulesWang/css.vim')
plug('NoahTheDuke/vim-just')
plug('cespare/vim-toml', {branch='main'})
plug('hashivim/vim-terraform')
plug('junegunn/fzf', {["do"]=vim.fn["fzf#install"]})
plug('junegunn/fzf.vim')
plug('justinj/vim-pico8-syntax')
plug('kshenoy/vim-signature')
plug('lotabout/skim.vim')
plug('mileszs/ack.vim')
plug('mitsuhiko/vim-jinja')
plug('niklasl/vim-rdf')
plug('othree/html5.vim')
plug('pangloss/vim-javascript')
plug('pest-parser/pest.vim')
plug('plasticboy/vim-markdown')
plug('preservim/nerdtree')
plug('rust-lang/rust.vim')
plug('tpope/vim-surround')
plug('xtfc/mold.vim')

vim.fn["plug#end"]()
