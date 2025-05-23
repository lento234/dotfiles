-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- line numbers
opt.number = true
opt.relativenumber = true

-- tab & indentation
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

opt.expandtab = true
opt.autoindent = true
opt.backspace = "indent,eol,start"

-- line wrapping
opt.wrap = false
-- opt.breakindent = true

-- filetypes
opt.encoding = "utf8"
opt.fileencoding = "utf8"

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- clipboard
vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)
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
opt.scrolloff = 4

-- sessions
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

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
		vim.highlight.on_yank()
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
