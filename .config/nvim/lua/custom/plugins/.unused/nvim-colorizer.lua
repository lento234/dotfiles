return {
	"norcalli/nvim-colorizer.lua",
	event = "VeryLazy",
	config = function()
		require("colorizer").setup({
			"css",
			"javascript",
			"vue",
			"typescript",
			"html",
		})
	end,
	keys = {
		{ "<leader>tc", ":ColorizerToggle<CR>", desc = "[t]oggle [c]olorized" },
	},
}
