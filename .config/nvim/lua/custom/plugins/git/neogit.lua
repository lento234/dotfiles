return {
	"NeogitOrg/neogit",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed, not both.
		"nvim-telescope/telescope.nvim", -- optional
		"ibhagwan/fzf-lua",            -- optional
		"echasnovski/mini.pick",       -- optional
	},
	keys = {
		{ "<leader>gg", ":Neogit<CR>", desc = "toggle neo[g]it [g]" },
	},
	config = function()
		require("neogit").setup({
			graph_style = "kitty",
		})
	end
}
