-- faster startup by caching
vim.loader.enable()

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- nerd font
vim.g.have_nerd_font = true

-- line numbers
vim.o.number = true
vim.o.relativenumber = true

-- enable mouse mode
vim.o.mouse = "a"

-- show mode
vim.o.showmode = false

-- tab & indentation
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.o.expandtab = true
vim.o.autoindent = true
vim.o.backspace = "indent,eol,start"

-- line wrapping
vim.o.wrap = false
-- opt.breakindent = true

-- filetypes
vim.o.encoding = "utf8"
vim.o.fileencoding = "utf8"

-- search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

-- Preview substitutions live, as you type!
-- vim.o.inccommand = 'split'

vim.o.confirm = true

-- clipboard
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
vim.o.undofile = true

-- splits
vim.o.splitright = true
vim.o.splitbelow = true

--  Theme and Appearances opts
vim.o.syntax = "ON"
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.cursorline = true
vim.o.scrolloff = 4

-- sessions
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- disable swap file (keep in memory)
vim.o.swapfile = false
