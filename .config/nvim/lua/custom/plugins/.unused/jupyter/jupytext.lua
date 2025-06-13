return {
	'GCBallesteros/jupytext.nvim',
	config = true,
	opts = {
		custom_language_formatting = {
			python = {
				extension = "md",
				style = "markdown",
				force_ft = "markdown", -- you can set whatever filetype you want here
			},
		}
	}
}
