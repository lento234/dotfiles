return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- setting the keybinding for LazyGit with 'keys' is recommended in
	-- order to load the plugin when the command is run for the first time
	keys = {
		-- { "<leader>lg", "<cmd>LazyGit<cr>",                  desc = "lazygit: [g]it [l]azygit ui" },
		{ "<leader>gc", "<cmd>LazyGitFilter<cr>",            desc = "lazygit: [g]it [c]ommits" },
		{ "<leader>gf", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "lazygit: [g]it current [f]ile" },
	},

}
