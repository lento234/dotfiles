return {
	"folke/todo-comments.nvim",
	event = { "VimEnter" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	keys = {
		{ "<leader>tt", "<cmd>TodoLocList<cr>", mode = { "n" }, desc = "[t]oggle [t]odo loclist" },
	},
}
