return {
	"leoluz/nvim-dap-go", -- Install the plugin with Packer
	config = function()
		require("dap-go").setup()
	end,
	ft = "go",
}
