return {
	"3rd/diagram.nvim",
	dependencies = {
		{ "3rd/image.nvim", opts = {} }, -- you'd probably want to configure image.nvim manually instead of doing this
	},
	opts = {
		renderer_options = {
			mermaid = {
				cli_args = { "-p", vim.fn.expand("~/.config/puppeteer-config.json") },
			},
		},
	},
}
