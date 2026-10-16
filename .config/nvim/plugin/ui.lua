-- colorscheme
vim.cmd.colorscheme("catppuccin-mocha")

-- statusline
require("lualine").setup({})

-- which-key
require("which-key").setup({
	delay = 300,
	icons = { mappings = vim.g.have_nerd_font },
	spec = {
		{ "<leader>s", group = "[s]earch", mode = { "n", "v" } },
		{ "<leader>t", group = "[t]oggle" },
		{ "<leader>h", group = "git [h]unk", mode = { "n", "v" } },
		{ "<leader>g", group = "[g]it", mode = { "n", "x" } },
		{ "<leader>d", group = "[d]iff" },
		{ "<leader>w", group = "[w]indow" },
		{ "<leader>m", group = "[m]arks" },
		{ "<leader>S", group = "[S]ession" },
		{ "gr", group = "LSP actions", mode = { "n" } },
		{ "gs", group = "[s]urround", mode = { "n", "x" } },
	},
})

-- todo comments
require("todo-comments").setup({ signs = false })

-- notifications and LSP progress; also routes vim.notify through fidget
require("fidget").setup({ notification = { override_vim_notify = true } })

-- colorizer
require("colorizer").setup({
	options = { parsers = { css = true, names = false } },
})

-- snacks
require("snacks").setup({
	bigfile = { enabled = true },
	image = { enabled = true },
	indent = { enabled = true },
	git = { enabled = true },
	gitbrowse = {
		url_patterns = {
			["git%.drz%.li"] = {
				branch = "/-/tree/{branch}",
				file = "/-/blob/{branch}/{file}#L{line_start}-{line_end}",
				permalink = "/-/blob/{commit}/{file}#L{line_start}-{line_end}",
				commit = "/-/commit/{commit}",
			},
		},
	},
})

-- file tree
require("neo-tree").setup({
	filesystem = {
		window = {
			mappings = {
				["\\"] = "close_window",
			},
		},
	},
})
vim.keymap.set("n", "<leader>n", "<cmd>Neotree toggle<CR>", { desc = "NeoTree toggle" })

-- sessions
require("auto-session").setup({
	-- neo-tree windows don't restore cleanly, close them before saving
	pre_save_cmds = { "tabdo Neotree close" },
	log_level = "error",
	suppressed_dirs = { "~/", "~/Downloads", "/" },
})
vim.keymap.set("n", "<leader>Ss", "<cmd>AutoSession save<CR>", { desc = "[S]ession: [s]ave" })
vim.keymap.set("n", "<leader>Sr", "<cmd>AutoSession restore<CR>", { desc = "[S]ession: [r]estore" })
vim.keymap.set("n", "<leader>Sd", "<cmd>AutoSession delete<CR>", { desc = "[S]ession: [d]elete" })
vim.keymap.set("n", "<leader>Sf", "<cmd>AutoSession search<CR>", { desc = "[S]ession: [f]ind" })
