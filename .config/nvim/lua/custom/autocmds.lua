-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("custom_highlight_yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
