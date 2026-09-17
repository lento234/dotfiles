return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.align").setup()
		require("mini.statusline").setup()
		require("mini.trailspace").setup()
	end,
}
