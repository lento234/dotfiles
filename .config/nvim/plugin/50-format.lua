-- formatting
vim.g.format_on_save = true

require("conform").setup({
	notify_on_error = false,
	format_on_save = function()
		if vim.g.format_on_save then
			return { timeout_ms = 500 }
		end
	end,
	default_format_opts = {
		-- use the formatters below when configured, otherwise LSP formatting
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		css = { "prettier" },
		cpp = { "clang-format" },
		html = { "prettier" },
		python = { "ruff_format", "ruff_organize_imports" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		vue = { "prettier" },
	},
})

vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
	vim.g.format_on_save = not vim.g.format_on_save
	vim.notify("format on save " .. (vim.g.format_on_save and "ENABLED" or "DISABLED"))
end, { desc = "Toggle format-on-save" })

vim.keymap.set("n", "<leader>tf", "<cmd>ToggleFormatOnSave<CR>", { desc = "[t]oggle [f]ormat on save" })
vim.keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format({ async = true })
end, { desc = "[f]ormat buffer" })

-- linting
local lint = require("lint")
lint.linters_by_ft = {
	markdown = { "markdownlint" },
	json = { "jsonlint" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = vim.api.nvim_create_augroup("custom_lint", { clear = true }),
	callback = function()
		-- skip read-only buffers such as LSP hover popups
		if vim.bo.modifiable then
			lint.try_lint()
		end
	end,
})
