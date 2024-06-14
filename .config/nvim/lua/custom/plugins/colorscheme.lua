return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- load the colorscheme here
		require("gruvbox").setup({
			contrast = "hard",
			overrides = {
				SignColumn = { bg = "#1d2021" },
				TabLineFill = { bg = "#1d2021" },
				TabLineSel = { bg = "#1d2021" },
				CursorLine = { bg = "#282828" },
			},
		})
		vim.cmd("colorscheme gruvbox")
	end,
}
