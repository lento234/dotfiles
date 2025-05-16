return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "work",
				path = "~/Documents/obsidian-vault",
			},
		},
		daily_notes = {
			folder = "Dailies",
			date_format = "%Y-%m-W%W",
		},
	},
	keys = {
		{ "<leader>oo", "<CMD>Obsidian<CR>",        desc = "[o]sidian" },
		{ "<leader>ot", "<CMD>Obsidian today<CR>",  desc = "[o]sidian [t]oday daily notes" },
		{ "<leader>os", "<CMD>Obsidian search<CR>", desc = "[o]sidian [s]earch" },
	},
}
