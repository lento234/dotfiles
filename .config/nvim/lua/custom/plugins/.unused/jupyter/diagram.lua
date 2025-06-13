return {
	"3rd/diagram.nvim",
	dependencies = {
		"3rd/image.nvim",
	},
	opts = {
		mermaid = {
			background = "transparent",
			theme = "dark", -- nil | "default" | "dark" | "forest" | "neutral"
			scale = 3,   -- nil | 1 (default) | 2  | 3 | ...
		},
	},
	config = function()
		require("diagram").setup({
			integrations = {
				require("diagram.integrations.markdown"),
				require("diagram.integrations.neorg"),
			},
			-- 		renderer_options = {
			-- 			mermaid = {
			-- 				theme = "dark",
			-- 			},
			-- 			plantuml = {
			-- 				charset = "utf-8",
			-- 			},
			-- 			d2 = {
			-- 				theme_id = 1,
			-- 			},
			-- 		},
		})
	end,
}
