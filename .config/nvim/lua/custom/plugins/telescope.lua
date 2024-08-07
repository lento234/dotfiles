return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ 'nvim-telescope/telescope-ui-select.nvim' },
		{ 'nvim-telescope/telescope-dap.nvim' },
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
				},
			},
		})

		-- Enable telescope fzf native, if installed
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
		telescope.load_extension("dap")
		-- require('telescope').load_extension('dap')
		-- require("telescope").load_extension('harpoon')

		local function noremap(mode, lhs, rhs, desc, opts)
			opts = opts or { silent = true }
			vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true, silent = opts["silent"] })
		end

		-- keymaps
		noremap("n", "<leader>?", require("telescope.builtin").oldfiles, "telescope: [?] Find recently opened files")
		noremap(
			"n",
			"<leader><space>",
			require("telescope.builtin").buffers,
			"telescope: [<space>] Find existing buffers"
		)
		noremap("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, "telescope: [/] Fuzzily search in current buffer")
		noremap("n", "<leader>fg", require("telescope.builtin").git_files, "telescope: [f]ind [g]it files")
		noremap("n", "<leader>ff", function()
			require("telescope.builtin").find_files({ hidden = true, ignore = false })
		end, "telescope: [f]ind [f]iles")
		noremap("n", "<leader>fh", require("telescope.builtin").help_tags, "telescope: [f]ind [h]elp")
		noremap("n", "<leader>fw", function()
			require("telescope.builtin").live_grep({ additional_args = { "--hidden" } })
		end, "telescope: [f]ind [w]ord")
		noremap(
			"n",
			"<leader>fs",
			require("telescope.builtin").lsp_document_symbols,
			"telescope: [f]ind document [s]ymbols"
		)
		noremap("n", "<leader>fk", require("telescope.builtin").keymaps, "telescope: [f]ind by [k]keymaps")
		noremap("n", "<leader>ft", ":TodoTelescope<CR>", "telescope: [f]ind [t]odo")
		noremap("n", "<leader>fr", require("telescope.builtin").registers, "telescope: [f]ind [r]egister")
		noremap("n", "<leader>fc", require("telescope.builtin").git_commits, "telescope: [f]ind git [c]ommits")
		noremap("n", "<leader>gs", require("telescope.builtin").git_status, "telescope: [g]it [s]tatus")
		-- noremap("n", "<leader>gw", require("telescope.builtin").grep_string, "telescope: [g]rep current [w]ord")
		-- keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
	end,
}
