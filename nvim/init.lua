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

plug("JulesWang/css.vim")
plug("NoahTheDuke/vim-just")
plug("cespare/vim-toml", {branch="main"})
plug("hashivim/vim-terraform")
plug("hrsh7th/cmp-nvim-lsp")
plug("hrsh7th/cmp-vsnip")
plug("hrsh7th/nvim-cmp")
plug("hrsh7th/vim-vsnip")
--plug("junegunn/fzf", {["do"]=vim.fn["fzf#install"]})
--plug("junegunn/fzf.vim")
plug("justinj/vim-pico8-syntax")
plug("kshenoy/vim-signature")
plug("lotabout/skim", {["dir"]="~/.skim", ["do"]="./install"})
plug("lotabout/skim.vim")
plug("mileszs/ack.vim")
plug("mitsuhiko/vim-jinja")
plug("neovim/nvim-lspconfig")
plug("niklasl/vim-rdf")
plug("othree/html5.vim")
plug("pangloss/vim-javascript")
plug("pest-parser/pest.vim")
plug("plasticboy/vim-markdown")
plug("preservim/nerdtree")
plug("rust-lang/rust.vim")
plug("tpope/vim-surround")
plug("xtfc/mold.vim")

vim.fn["plug#end"]()

-- LSP config
local lspconfig = require("lspconfig")
lspconfig.pyright.setup({})
-- lspconfig.lua_ls.setup({})

-- disable treesitter for lua files
vim.api.nvim_create_autocmd(
  {"BufEnter"},
  {pattern = "*.lua", callback = function(ev) vim.treesitter.stop() end}
)


-- autocomplete
local cmp = require("cmp")

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})
