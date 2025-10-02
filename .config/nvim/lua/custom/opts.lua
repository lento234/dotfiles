-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- line numbers
vim.o.number = true
vim.o.relativenumber = true

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

-- Highlight on yank (copy)
local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end
-- vim.api.nvim_exec(
-- 	[[
--   augroup YankHighlight
--     autocmd!
--     autocmd TextYankPost * silent! lua vim.highlight.on_yank()
--   augroup end
-- ]],
-- 	false
-- )
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- remove whitespace warning in terminal
-- vim.api.nvim_exec(
-- 	[[
--   augroup vimrc
--     autocmd TermOpen * :DisableWhitespace
--   augroup END
-- ]],
-- 	false
-- )
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- format on save
vim.g.format_on_save = true
vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
	vim.g.format_on_save = not vim.g.format_on_save
	local fidget = require("fidget")
	if vim.g.format_on_save then
		fidget.notify("format on save", nil, { annote = "ENABLED", key = "formatonsave" })
	else
		fidget.notify("format on save", nil, { annote = "DISABLED", key = "formatonsave" })
	end
end, {
	desc = "Toggle format-on-save",
	bang = true,
})
