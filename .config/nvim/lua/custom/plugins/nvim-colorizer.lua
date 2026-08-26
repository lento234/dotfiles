return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	opts = {
		options = { parsers = { css = true, names = false } },
	},
	keys = {
		{ "<leader>tc", ":ColorizerToggle<CR>", desc = "[t]oggle [c]olorized" },
	},
}
