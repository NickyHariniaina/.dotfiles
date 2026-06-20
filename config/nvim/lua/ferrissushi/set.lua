local opt = vim.opt
local o = vim.o
local g = vim.g


opt.scrolloff = 8
opt.nu = true
opt.mouse = "a"
opt.guicursor = "a:block-blinkon1-blinkoff1"
opt.relativenumber = true
opt.number = true
opt.undofile = true
opt.cursorline = false
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.ignorecase = true
opt.smartcase = true
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.hlsearch = false
opt.incsearch = true
opt.colorcolumn = "100"
opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.termguicolors = true
opt.signcolumn = "yes"
opt.isfname:append("@-@")
opt.updatetime = 100
opt.showmode = false
g.have_nerd_font = true
o.timeoutlen = 500
vim.lsp.inlay_hint.enable(false)
