return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- load the colorscheme here
		require("gruvbox").setup({
			contrast = "hard",
			overrides = {
				SignColumn               = { bg = "#1d2021" },
				TabLineFill              = { bg = "#1d2021" },
				TabLineSel               = { bg = "#1d2021" },
				CursorLine               = { bg = "#282828" },
				-- nvim-tree
				NvimTreeFolderIcon       = { link = "GruvboxBlueBold" },
				NvimTreeFolderName       = { link = "GruvboxBlue" },
				NvimTreeOpenedFolderName = { link = "GruvboxBlueBold" },
				NvimTreeEmptyFolderName  = { link = "GruvboxBlue" },
				-- neo-tree
				NeoTreeDirectoryIcon     = { link = "GruvboxBlueBold" },
				NeoTreeDirectoryName     = { link = "GruvboxBlue" },
				NeoTreeRootName          = { link = "GruvboxPurpleBold" },
			},
		})
		vim.cmd("colorscheme gruvbox")
	end,
}
