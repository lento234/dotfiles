return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{ "<leader>z",  function() Snacks.zen() end,                     desc = "Toggle Zen Mode" },
		{ "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
		{ "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
		{ "<leader>lg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
		{ "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
		{ "<leader>k",  function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",   mode = { "n", "t" } },
		{ "<leader>j",  function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",   mode = { "n", "t" } },
	},
	config = function()
		require("snacks").setup(
			{
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				bigfile = { enabled = true },
				indent = {
					enabled = false, -- enable indent guides
				},
				input = { enabled = true },
				git = { enabled = true },
				lazygit = { enabled = true },
				notifier = { enabled = false },
				quickfile = { enabled = true },
				scroll = { enabled = true },
				statuscolumn = { enabled = true },
				-- terminal = { enabled = true },
				-- words = {
				-- 	debounce = 200, -- time in ms to wait before updating
				-- 	-- enabled = true
				-- },
			}
		)
	end
}
