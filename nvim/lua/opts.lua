local opt = vim.opt

-- line numbers
opt.number = true
-- opt.relativenumber = true

-- tab & indentation
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.backspace = "indent,eol,start"

-- line wrapping
opt.wrap = false
-- opt.breakindent = true

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

--  Theme and Appearances opts
opt.syntax = "ON"
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
vim.o.updatetime = 250
opt.cursorline = true

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

-- Highlight on yank (copy)
vim.api.nvim_exec(
  [[
  augroup vimrc
    autocmd TermOpen * :DisableWhitespace
  augroup END
]],
  false
)
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

