return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},

	keys = {
		{ "<leader>n",  ":Neotree toggle current float reveal_force_cwd<cr>", desc = "tree: show file in floating [n]eo-tree", silent = true },
		{ "<leader>tt", ":Neotree toggle left reveal_force_cwd<cr>",          desc = "tree: show file in [n]eo-tree",          silent = true },
	},
}
