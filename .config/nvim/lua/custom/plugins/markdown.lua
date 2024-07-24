return {
	'MeanderingProgrammer/markdown.nvim',
	main = "render-markdown",
	opts = {},
	name = 'render-markdown',                                                           -- Only needed if you have another plugin named markdown.nvim
	dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	keys = {
		{ "<leader>tm", ":RenderMarkdown toggle<CR>", desc = "[t]oggle [m]arkdown", silent = true },
	},
}
