return {
	"NeogitOrg/neogit",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed, not both.
		"ibhagwan/fzf-lua", -- optional
	},
	keys = {
		{ "<leader>gg", ":Neogit<CR>", desc = "toggle neo[g]it [g]" },
	},
	config = function()
		require("neogit").setup({
			graph_style = "kitty",
		})
	end,
}
