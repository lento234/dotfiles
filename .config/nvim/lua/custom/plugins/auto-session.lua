return {
	"rmagatti/auto-session",
	lazy = false,
	keys = {
		{ "<leader>ss", ":SessionSave<CR>",    desc = "[s]session: [s]ave" },
		{ "<leader>sd", ":SessionDelete<CR>",  desc = "[s]session: [d]elete" },
		{ "<leader>sr", ":SessionRestore<CR>", desc = "[s]session: [r]estore" },
	},
	config = function()
		require("auto-session").setup({
			-- pre_save_cmds = { "NeoTree close" },
			pre_save_cmds = { "NvimTreeClose" },
			log_level = "error",
			suppressed_dirs = { '~/', '~/Downloads', '/' },
		})
	end,
}
