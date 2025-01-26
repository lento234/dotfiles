return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1001, -- this plugin needs to run before anything else
		opts = {
			rocks = { "magick" },
		},
	},
	{
		"3rd/image.nvim",
		dependencies = { "luarocks.nvim" },
		config = function()
			-- default config
			require("image").setup({
				backend = "kitty",
				integrations = {
					markdown = {
						enabled = true,
						clear_in_insert_mode = true,
						download_remote_images = false,
						only_render_image_at_cursor = true, -- or true
						editor_only_render_when_focused = false,
						tmux_show_only_in_active_window = true,
						window_overlap_clear_enabled = true,
						window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "scrollview", "scrollview_sign" },
						max_width = 100,                    -- tweak to preference
						max_height = 12,                    -- ^
						max_height_window_percentage = math.huge, -- this is necessary for a good experience
						max_width_window_percentage = math.huge,
						kitty_method = "normal",
						filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
					},
				},
				hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
			})
		end,
	},
}
