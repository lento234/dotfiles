return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "[g]it: [B]rowse",
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "[g]it: [b]lame line",
		},
		{
			"<leader>glg",
			function()
				Snacks.lazygit.log()
			end,
			desc = "[g]it: [l]azygit [l]og [g]raph",
		},
		{
			"<leader>gll",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "[g]it: [l]og [l]ine",
		},
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>k",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>j",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>ms",
			function()
				Snacks.picker.marks()
			end,
			desc = "[m]arks: [s]how",
		},
	},
	config = function()
		require("snacks").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			animate = { enabled = true },
			bigfile = { enabled = true },
			-- indent = { enabled = true },
			input = { enabled = true },
			image = { enabled = true },
			git = { enabled = true },
			gitbrowse = {
				url_patterns = {
					["git.drz.li"] = {
						branch = "/-/tree/{branch}",
						file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
						permalink = "/-/blob/{commit}/{file}#L{line_start}-L{line_end}",
						commit = "/-/commit/{commit}",
					},
				},
			},
			lazygit = { enabled = true },
			-- notifier = { enabled = true },
			picker = { enabled = true },
			quickfile = { enabled = true },
			-- scroll = { enabled = true },
			statuscolumn = { enabled = true },
			-- terminal = { enabled = true },
			-- words = {
			-- 	-- 	debounce = 200, -- time in ms to wait before updating
			-- 	enabled = true
			-- },
		})
	end,
}
