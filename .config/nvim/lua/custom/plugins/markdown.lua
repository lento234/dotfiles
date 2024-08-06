return {
	"OXY2DEV/markview.nvim",
	lazy = false, -- Recommended
	-- ft = "markdown" -- If you decide to lazy-load anyway
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons"
	},
	keys = {
		{ "<leader>tm", ":Markview<CR>", desc = "[t]oggle [m]arkdown", silent = true },
	},
}
