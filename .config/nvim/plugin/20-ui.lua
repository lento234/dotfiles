-- colorscheme
vim.cmd.colorscheme("catppuccin-mocha")

-- statusline
require("lualine").setup({})

-- buffer tabline
-- barbar's own plugin/ file calls setup({}) unless this is false, which would reset the options below
vim.g.barbar_auto_setup = false
require("barbar").setup({
	animation = false,
	-- keep the tabline aligned when neo-tree is open
	sidebar_filetypes = { ["neo-tree"] = { event = "BufWipeout" } },
})
vim.keymap.set("n", "<C-q>", "<cmd>BufferClose<CR>", { desc = "buffer close" })
vim.keymap.set("n", "<A-h>", "<cmd>BufferPrevious<CR>", { desc = "buffer prev" })
vim.keymap.set("n", "<A-l>", "<cmd>BufferNext<CR>", { desc = "buffer next" })
vim.keymap.set("n", "<A-H>", "<cmd>BufferMovePrevious<CR>", { desc = "buffer move to prev" })
vim.keymap.set("n", "<A-L>", "<cmd>BufferMoveNext<CR>", { desc = "buffer move to next" })
vim.keymap.set("n", "<C-p>", "<cmd>BufferPick<CR>", { desc = "buffer [p]ick" })
vim.keymap.set("n", "<A-p>", "<cmd>BufferPin<CR>", { desc = "buffer pin" })
vim.keymap.set("n", "<leader>cc", "<cmd>BufferCloseAllButCurrent<CR>", { desc = "buffer [c]lose all but [c]urrent" })

-- which-key
require("which-key").setup({
	delay = 300,
	icons = { mappings = vim.g.have_nerd_font },
	spec = {
		{ "<leader>s", group = "[s]earch", mode = { "n", "v" } },
		{ "<leader>t", group = "[t]oggle" },
		{ "<leader>h", group = "git [h]unk", mode = { "n", "v" } },
		{ "<leader>g", group = "[g]it", mode = { "n", "x" } },
		{ "<leader>gl", group = "[g]it [l]og" },
		{ "<leader>l", group = "[l]sp / [l]azygit" },
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
vim.keymap.set("n", "<leader>tt", "<cmd>TodoLocList<CR>", { desc = "[t]oggle [t]odo loclist" })

-- notifications and LSP progress; also routes vim.notify through fidget
require("fidget").setup({ notification = { override_vim_notify = true } })

-- colorizer
require("colorizer").setup({
	options = { parsers = { css = true, names = false } },
})
vim.keymap.set("n", "<leader>tc", "<cmd>ColorizerToggle<CR>", { desc = "[t]oggle [c]olorizer" })

-- markdown preview (lazy-loads itself, so it's set up eagerly as its README recommends)
require("markview").setup({
	preview = {
		-- mini.icons is only set up with a nerd font, see plugin/10-editor.lua
		icon_provider = vim.g.have_nerd_font and "mini" or "internal",
	},
})
vim.keymap.set("n", "<leader>tm", "<cmd>Markview Toggle<CR>", { desc = "[t]oggle [m]arkdown preview" })

-- snacks
require("snacks").setup({
	bigfile = { enabled = true },
	image = { enabled = true },
	indent = { enabled = true },
	-- fuzzy finder and vim.ui.select, see plugin/70-search.lua
	picker = { enabled = true },
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
		follow_current_file = { enabled = true, leave_dirs_open = true },
		window = {
			mappings = {
				["\\"] = "close_window",
			},
		},
	},
})
vim.keymap.set("n", "<leader>n", "<cmd>Neotree toggle reveal<CR>", { desc = "NeoTree toggle, revealing current file" })

-- sessions
require("auto-session").setup({
	pre_save_cmds = {
		-- neo-tree windows don't restore cleanly, close them before saving
		"tabdo Neotree close",
		-- lets barbar store buffer order and pins (needs "globals" in sessionoptions)
		function()
			vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
		end,
	},
	log_level = "error",
	suppressed_dirs = { "~/", "~/Downloads", "/" },
})
vim.keymap.set("n", "<leader>Ss", "<cmd>AutoSession save<CR>", { desc = "[S]ession: [s]ave" })
vim.keymap.set("n", "<leader>Sr", "<cmd>AutoSession restore<CR>", { desc = "[S]ession: [r]estore" })
vim.keymap.set("n", "<leader>Sd", "<cmd>AutoSession delete<CR>", { desc = "[S]ession: [d]elete" })
vim.keymap.set("n", "<leader>Sf", "<cmd>AutoSession search<CR>", { desc = "[S]ession: [f]ind" })
