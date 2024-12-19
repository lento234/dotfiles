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

		local function noremap(mode, lhs, rhs, desc, opts)
			opts = opts or { silent = true }
			vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true, silent = opts["silent"] })
		end

		-- keymaps
		noremap("n", "<leader>ff", function() require("fzf-lua").files() end, "fzf-lua: [f]ind [f]iles")
		noremap("n", "<leader>fr", function() require("fzf-lua").files({ resume = true }) end,
			"fzf-lua: [f]ind files [r]esume")
		noremap("n", "<leader><space>", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
			"fzf-lua: [<space>] switch buffers")
		noremap("n", "<leader>:", "<cmd>FzfLua command_history<cr>", "fzf-lua: [:] show command history")
		noremap("n", "<leader>fg", "<cmd>FzfLua git_files<cr>", "fzf-lua: [f]ind [g]it files")


		-- git
		noremap("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", "fzf-lua: [g]it [c]ommits")
		noremap("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", "fzf-lua: [g]it [s]tatus")

		-- search
		noremap("n", '<leader>s"', "<cmd>FzfLua registers<cr>", "fzf-lua: [s]earch [\"]registers")
		noremap("n", "<leader>sw", "<cmd>FzfLua grep_curbuf<cr>", "fzf-lua: [s]earch [w]ord in current buffer")

		-- keymaps
		-- noremap("n", "<leader>?", require("telescope.builtin").oldfiles, "telescope: [?] Find recently opened files")

		-- -- noremap(
		-- -- 	"n",
		-- -- 	"<leader><space>",
		-- -- 	require("telescope.builtin").buffers,
		-- -- 	"telescope: [<space>] Find existing buffers"
		-- -- )
		-- -- noremap("n", "<leader>/", function()
		-- -- 	-- You can pass additional configuration to telescope to change theme, layout, etc.
		-- -- 	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		-- -- 		winblend = 10,
		-- -- 		previewer = false,
		-- -- 	}))
		-- -- end, "telescope: [/] Fuzzily search in current buffer")
		--
		-- -- noremap("n", "<leader>fg", require("telescope.builtin").git_files, "telescope: [f]ind [g]it files")
		--
		-- -- noremap("n", "<leader>ff", function()
		-- -- 	require("telescope.builtin").find_files({ hidden = true, ignore = false })
		-- -- end, "telescope: [f]ind [f]iles")
		--
		-- noremap("n", "<leader>fh", require("telescope.builtin").help_tags, "telescope: [f]ind [h]elp")
		--
		-- noremap("n", "<leader>fw", function()
		-- 	require("telescope.builtin").live_grep()
		-- end, "telescope: [f]ind [w]ord")
		--
		-- noremap("n", "<leader>faw", function()
		-- 	require("telescope.builtin").live_grep({ additional_args = { "--hidden" } })
		-- end, "telescope: [f]ind [a]ll [w]ord")
		--
		-- -- noremap(
		-- -- 	"n",
		-- -- 	"<leader>fs",
		-- -- 	require("telescope.builtin").lsp_document_symbols,
		-- -- 	"telescope: [f]ind document [s]ymbols"
		-- -- )
		-- noremap("n", "<leader>fk", require("telescope.builtin").keymaps, "telescope: [f]ind by [k]keymaps")
		-- noremap("n", "<leader>ft", ":TodoTelescope<CR>", "telescope: [f]ind [t]odo")
		-- -- noremap("n", "<leader>fr", require("telescope.builtin").registers, "telescope: [f]ind [r]egister")
		-- noremap("n", "<leader>fc", require("telescope.builtin").git_commits, "telescope: [f]ind git [c]ommits")
		-- -- noremap("n", "<leader>gs", require("telescope.builtin").git_status, "telescope: [g]it [s]tatus")
		-- -- noremap("n", "<leader>gw", require("telescope.builtin").grep_string, "telescope: [g]rep current [w]ord")
		-- -- keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
		-- --
	end
}
