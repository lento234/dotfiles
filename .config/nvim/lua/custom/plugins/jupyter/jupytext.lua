return {
	-- directly open ipynb files
	-- and convert back behind the scenes
	'GCBallesteros/jupytext.nvim',
	config = function()
		require("jupytext").setup({
			style = "markdown",
			output_extension = "md",
			force_ft = "markdown",
		})
	end,
}
