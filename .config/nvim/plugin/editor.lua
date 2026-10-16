-- mini.nvim: a collection of small independent modules
-- icons go first so later plugins pick up the devicons mock
if vim.g.have_nerd_font then
	require("mini.icons").setup({})
	MiniIcons.mock_nvim_web_devicons()
end

-- better around/inside textobjects
require("mini.ai").setup({ n_lines = 500 })

-- add/delete/replace surroundings (brackets, quotes, etc.)
-- uses a `gs` prefix so it doesn't clash with flash on `s`
require("mini.surround").setup({
	mappings = {
		add = "gsa",
		delete = "gsd",
		find = "gsf",
		find_left = "gsF",
		highlight = "gsh",
		replace = "gsr",
		update_n_lines = "gsn",
	},
})

require("mini.pairs").setup({})
require("mini.trailspace").setup()

-- indentation
require("guess-indent").setup({})

-- flash
require("flash").setup({})
vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash [s]earch" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function()
	require("flash").remote()
end, { desc = "Remote Flash" })

-- tmux integration
local nvim_tmux_nav = require("nvim-tmux-navigation")
nvim_tmux_nav.setup({ disable_when_zoomed = true })
vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, { desc = "navigate left" })
vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, { desc = "navigate down" })
vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, { desc = "navigate up" })
vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, { desc = "navigate right" })
