local opt = vim.opt

-- line numbers
opt.number = true
-- opt.relativenumber = true

-- tab & indentation
opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- filetypes
opt.encoding = 'utf8'
opt.fileencoding = 'utf8'

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- clipboard
opt.clipboard:append("unnamedplus")

-- splits
opt.splitright = true
opt.splitbelow = true

--  Theme and Appearances
opt.syntax = "ON"
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

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

