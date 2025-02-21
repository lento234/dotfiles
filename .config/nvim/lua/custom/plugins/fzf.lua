return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },

	-- keys = {
	-- 	{ "<leader>ff", require("fz-lua").files, desc = "[f]ind [f]iles", silent = true },
	-- },
	-- opts = {},
	config = function()
		-- calling `setup` is optional for customization
		require("fzf-lua").setup({})
		-- require("fzf-lua").setup({ 'fzf-tmux' })

		local function noremap(mode, lhs, rhs, desc, opts)
			opts = opts or { silent = true }
			vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true, silent = opts["silent"] })
		end

		-- find
		noremap("n", "<leader>ff", function() require("fzf-lua").files() end, "fzf-lua: [f]ind [f]iles")
		noremap("n", "<leader>fr", function() require("fzf-lua").files({ resume = true }) end,
			"fzf-lua: [f]ind files [r]esume")
		noremap("n", "<leader><space>", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
			"fzf-lua: [<space>] switch buffers")
		noremap("n", "<leader>:", "<cmd>FzfLua command_history<cr>", "fzf-lua: [:] show command history")
		noremap("n", "<leader>fg", "<cmd>FzfLua git_files<cr>", "fzf-lua: [f]ind [g]it files")
		noremap("n", "<leader>fk", "<cmd>FzfLua keymaps<cr>", "fzf-lua: [f]ind [k]keymaps")
		noremap("n", "<leader>fw", "<cmd>FzfLua grep_project<cr>", "fzf-lua: [f]ind [w]ord in project")
		noremap("n", "<leader>fm", "<cmd>FzfLua marks<cr>", "fzf-lua: [f]ind [m]arks")


		-- git
		noremap("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", "fzf-lua: [g]it [c]ommits")
		noremap("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", "fzf-lua: [g]it [s]tatus")

		-- search
		noremap("n", '<leader>s"', "<cmd>FzfLua registers<cr>", "fzf-lua: [s]earch [\"]registers")
		noremap("n", "<leader>sw", "<cmd>FzfLua grep_curbuf<cr>", "fzf-lua: [s]earch [w]ord in current buffer")
		noremap("n", "<leader>sS", function() require("fzf-lua").lsp_live_workspace_symbols({}) end,
			"Goto Symbol (Workspace)")
	end
}
