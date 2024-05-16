return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			-- Conform will run multiple formatters sequentially
			css = { "prettier" },
			cpp = { "clang-format" },
			html = { "prettier" },
			lua = { "stylua" },
			python = { "ruff_lsp" },
			-- Use a sub-list to run only the first available formatter
			-- javascript = { { "prettierd", "prettier" } },
			javascript = { "prettier" },
			typescript = { "prettier" },
		},
		format_on_save = function(bufnr)
			if not vim.g.format_on_save then
				return
			end
			if vim.bo[bufnr].filetype == "vue" then
				return { timeout_ms = 500, lsp_fallback = false, formatters = { "prettier" } }
			end
			return { timeout_ms = 500, lsp_fallback = true }
		end,
	},
}
