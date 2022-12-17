local opt = vim.opt

-- line numbers
opt.number = true
-- opt.relativenumber = true

-- tab & indentation
opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.backspace = "indent,eol,start"

-- line wrapping
opt.wrap = true
opt.breakindent = true

-- filetypes
opt.encoding = 'utf8'
opt.fileencoding = 'utf8'

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- clipboard
opt.clipboard:append("unnamedplus")
opt.undofile = true

-- splits
opt.splitright = true
opt.splitbelow = true

--  Theme and Appearances
opt.syntax = "ON"
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
vim.o.updatetime = 250
opt.cursorline = true

-- vim.cmd([[colorscheme moonfly]])
-- vim.cmd([[colorscheme gruvbox]])
require('onedark').load()

-- Highlight on yank (copy)
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

