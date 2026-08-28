local function run_build(name, cmd, cwd)
	local result = vim.system(cmd, { cwd = cwd }):wait()
	if result.code ~= 0 then
		local stderr = result.stderr or ""
		local stdout = result.stdout or ""
		local output = stderr ~= "" and stderr or stdout
		if output == "" then
			output = "no output from build command"
		end
		vim.notify(("build failed for %s:\n%s"):format(name, output), vim.log.levels.ERROR)
	end
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind ~= "install" and kind ~= "update" then
			return
		end

		if name == "telescope-fzf-native.nvim" and vim.fn.executable("make") == 1 then
			run_build(name, { "make" }, ev.data.path)
			return
		end

		if name == "LuaSnip" then
			if vim.fn.has("win32") ~= 1 and vim.fn.executable("make") == 1 then
				run_build(name, { "make", "install_jsregexp" }, ev.data.path)
			end
			return
		end

		if name == "nvim-treesitter" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
			return
		end
	end,
})

local function gh(repo)
	return "https://github.com/" .. repo
end

-- colorscheme
vim.pack.add({ { src = gh("catppuccin/nvim"), name = "catppuccin" } })
vim.cmd.colorscheme("catppuccin-mocha")

-- mini.nvim
--  A collection of various small independent plugins/modules
vim.pack.add({ gh("nvim-mini/mini.nvim") })
if vim.g.have_nerd_font then
	require("mini.icons").setup({})
	MiniIcons.mock_nvim_web_devicons()
end

-- Better Around/Inside textobjects
require("mini.ai").setup({
	mappings = {
		around_next = "aa",
		inside_next = "ii",
	},
	n_lines = 500,
})
-- Add/delete/replace surroundings (brackets, quotes, etc.)
require("mini.surround").setup({})

-- Simple and easy statusline.
local statusline = require("mini.statusline")
-- Set `use_icons` to true if you have a Nerd Font
statusline.setup({ use_icons = vim.g.have_nerd_font })
statusline.section_location = function()
	return "%2l:%-2v"
end

-- mini pairs
vim.pack.add({ gh("nvim-mini/mini.pairs") })
require("mini.pairs").setup({})

-- formatting
-- indentation
vim.pack.add({ gh("NMAC427/guess-indent.nvim") })
require("guess-indent").setup({})

-- git
vim.pack.add({ gh("lewis6991/gitsigns.nvim") })
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)

		-- actions
		-- visual mode
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "stage git hunk" })
		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "reset git hunk" })
		-- normal mode
		map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git stage hunk" })
		map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git reset hunk" })
		map("n", "<leader>hs", gitsigns.stage_buffer, { desc = "git stage buffer" })
		map("n", "<leader>hu", gitsigns.stage_hunk, { desc = "undo stage hunk" })
		map("n", "<leader>hr", gitsigns.reset_buffer, { desc = "git reset buffer" })
		map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "preview git hunk" })
		map("n", "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end, { desc = "git blame line" })
		map("n", "<leader>hb", function()
			gitsigns.blame()
		end, { desc = "git blame buffer" })
		map("n", "<leader>hd", gitsigns.diffthis, { desc = "git diff against index" })
		map("n", "<leader>hd", function()
			gitsigns.diffthis("~")
		end, { desc = "git diff against last commit" })

		-- toggles
		map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "toggle git blame line" })
		map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "toggle git show deleted" })

		-- text object
		map({ "o", "x" }, "ih", ":<c-u>gitsigns select_hunk<cr>", { desc = "select git hunk" })
	end,
})

local function noremap(mode, lhs, rhs, desc, opts)
	opts = opts or { silent = true }
	vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true, silent = opts["silent"] })
end

-- neogit
vim.pack.add({ gh("NeogitOrg/neogit") })
noremap("n", "<leader>gg", "<cmd>Neogit<cr>", "[g]o neo[g]it")

-- which-key
vim.pack.add({ gh("folke/which-key.nvim") })
require("which-key").setup({
	delay = 300,
	icons = { mappings = vim.g.have_nerd_font },
	spec = {
		{ "<leader>s", group = "[s]earch", mode = { "n", "v" } },
		{ "<leader>t", group = "[t]oggle" },
		{ "<leader>h", group = "git [h]unk", mode = { "n", "v" } },
		{ "gr", group = "LSP actions", mode = { "n" } },
	},
})

-- todo commenets
vim.pack.add({ gh("folke/todo-comments.nvim") })
require("todo-comments").setup({ signs = false })

-- neotree
vim.pack.add({
	{ src = gh("nvim-neo-tree/neo-tree.nvim"), version = vim.version.range("*") },
	gh("nvim-lua/plenary.nvim"),
	gh("MunifTanjim/nui.nvim"),
})
require("neo-tree").setup({
	filesystem = {
		window = {
			mappings = {
				["\\"] = "close_window",
			},
		},
	},
})
noremap("n", "<leader>n", "<cmd>Neotree toggle<cr>", "NeoTree reveal")

-- search and navigation

local telescope_plugins = {
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-telescope/telescope-ui-select.nvim"),
}
if vim.fn.executable("make") == 1 then
	table.insert(telescope_plugins, gh("nvim-telescope/telescope-fzf-native.nvim"))
end
vim.pack.add(telescope_plugins)
require("telescope").setup({
	extensions = {
		["ui-select"] = { require("telescope.themes").get_dropdown() },
	},
})
-- Enable Telescope extensions if they are installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")
-- noremap('n', '<leader>sh', builtin.help_tags, '[S]earch [H]elp')
noremap("n", "<leader>sk", builtin.keymaps, "[s]earch [k]eymaps")
noremap("n", "<leader>sf", builtin.find_files, "[s]earch [f]iles")
noremap("n", "<leader>ss", builtin.builtin, "[s]earch [s]elect Telescope")
noremap({ "n", "v" }, "<leader>sw", builtin.grep_string, "[s]earch current [w]ord")
noremap("n", "<leader>sg", builtin.live_grep, "[s]earch by [g]rep")
noremap("n", "<leader>sd", builtin.diagnostics, "[s]earch [d]iagnostics")
noremap("n", "<leader>sr", builtin.resume, "[s]earch [r]esume")
noremap("n", "<leader>s.", builtin.oldfiles, '[s]earch Recent Files ("." for repeat)')
-- noremap('n', '<leader>sc', builtin.commands, '[s]earch [c]ommands')
noremap("n", "<leader><leader>", builtin.buffers, "[ ] Find existing buffers")

-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
	callback = function(event)
		local buf = event.buf
		-- Find references for the word under your cursor.
		vim.keymap.set("n", "grr", builtin.lsp_references, { buffer = buf, desc = "[g]oto [r]eferences" })
		vim.keymap.set("n", "gri", builtin.lsp_implementations, { buffer = buf, desc = "[g]oto [i]mplementation" })
		vim.keymap.set("n", "grd", builtin.lsp_definitions, { buffer = buf, desc = "[g]oto [d]efinition" })
		vim.keymap.set(
			"n",
			"gO",
			builtin.lsp_document_symbols,
			{ buffer = buf, desc = "[g]oto [O]pen Document Symbols" }
		)
		vim.keymap.set(
			"n",
			"gW",
			builtin.lsp_dynamic_workspace_symbols,
			{ buffer = buf, desc = "[g]oto Open [W]orkspace Symbols" }
		)
		vim.keymap.set("n", "grt", builtin.lsp_type_definitions, { buffer = buf, desc = "[g]oto [t]ype Definition" })
	end,
})

noremap("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, "[/] Fuzzily search in current buffer")

noremap("n", "<leader>s/", function()
	builtin.live_gDep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, "[s]earch [/] in Open Files")

-- LSP
--
vim.pack.add({ gh("j-hui/fidget.nvim") })
require("fidget").setup({})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
		map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method("textDocument/documentHighlight", event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		-- The following code creates a keymap to toggle inlay hints in your
		-- code, if the language server you are using supports them
		--
		-- This may be unwanted, since they displace some of your code
		if client and client:supports_method("textDocument/inlayHint", event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

local servers = {
	-- clangd = {},
	-- gopls = {},
	-- pyright = {},
	-- rust_analyzer = {},
	-- But for many setups, the LSP (`ts_ls`) will work just fine
	-- ts_ls = {},
	stylua = {}, -- Used to format Lua code
	-- Special Lua Config, as recommended by neovim help docs
	lua_ls = {
		on_init = function(client)
			client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
				then
					return
				end
			end

			local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
			client.config.settings.Lua = vim.tbl_deep_extend("force", current_settings.Lua, {
				runtime = {
					version = "LuaJIT",
					path = { "lua/?.lua", "lua/?/init.lua" },
				},
				workspace = {
					checkThirdParty = false,
					library = vim.api.nvim_get_runtime_file("", true),
				},
			})
		end,
		---@type lspconfig.settings.lua_ls
		settings = {
			Lua = {
				format = { enable = false }, -- Disable formatting (formatting is done by stylua)
			},
		},
	},
}

vim.pack.add({
	gh("neovim/nvim-lspconfig"),
	gh("mason-org/mason.nvim"),
	gh("mason-org/mason-lspconfig.nvim"),
	gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
})

-- Automatically install LSPs and related tools to stdpath for Neovim
require("mason").setup({})

-- Translates between nvim-lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
require("mason-lspconfig").setup({
	automatic_enable = false, -- Change this to true if you want to automatically enable servers that are installed manually (e.g. via :Mason / :MasonInstall)
})

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	-- You can add other tools here that you want Mason to install
})

require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

for name, server in pairs(servers) do
	vim.lsp.config(name, server)
	vim.lsp.enable(name)
end

vim.pack.add({ gh("stevearc/conform.nvim") })
require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		if not vim.g.format_on_save then
			return
		end
		-- You can specify filetypes to autoformat on save here:
		local disable_filetypes = {
			-- lua = true,
			-- python = true,
		}
		if not disable_filetypes[vim.bo[bufnr].filetype] then
			return { timeout_ms = 500 }
		else
			return nil
		end
	end,
	default_format_opts = {
		lsp_format = "fallback", -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
	},
	-- You can also specify external formatters in here.
	formatters_by_ft = {
		css = { "prettier" },
		cpp = { "clang-format" },
		html = { "prettier" },
		-- rust = { 'rustfmt' },
		-- Conform can also run multiple formatters sequentially
		-- python = { "isort", "black" },
		python = { "ruff_format", "ruff_organize_imports" },
		--
		-- You can use 'stop_after_first' to run the first available formatter from the list
		javascript = { "prettier" },
		typescript = { "prettier" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format({ async = true })
end, { desc = "[f]ormat buffer" })

-- treesitter
vim.pack.add({ { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" } })

-- Ensure basic parsers are installed
local parsers =
	{ "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc" }
require("nvim-treesitter").install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
	-- Check if a parser exists and load it
	if not vim.treesitter.language.add(language) then
		return
	end
	-- Enable syntax highlighting and other treesitter features
	vim.treesitter.start(buf, language)

	-- Enable treesitter based folds
	-- For more info on folds see `:help folds`
	-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	-- vim.wo.foldmethod = 'expr'

	-- Check if treesitter indentation is available for this language, and if so enable it
	-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
	local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

	-- Enable treesitter based indentation
	if has_indent_query then
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
end

local available_parsers = require("nvim-treesitter").get_available()
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local buf, filetype = args.buf, args.match

		local language = vim.treesitter.language.get_lang(filetype)
		if not language then
			return
		end

		local installed_parsers = require("nvim-treesitter").get_installed("parsers")

		if vim.tbl_contains(installed_parsers, language) then
			-- Enable the parser if it is already installed
			treesitter_try_attach(buf, language)
		elseif vim.tbl_contains(available_parsers, language) then
			-- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
			require("nvim-treesitter").install(language):await(function()
				treesitter_try_attach(buf, language)
			end)
		else
			-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
			treesitter_try_attach(buf, language)
		end
	end,
})

-- linting
vim.pack.add({ gh("mfussenegger/nvim-lint") })

local lint = require("lint")
lint.linters_by_ft = {
	markdown = { "markdownlint" }, -- Make sure to install `markdownlint` via mason / npm
	json = { "jsonlint" },
}

-- To allow other plugins to add linters to require('lint').linters_by_ft,
-- instead set linters_by_ft like this:
-- lint.linters_by_ft = lint.linters_by_ft or {}
-- lint.linters_by_ft['markdown'] = { 'markdownlint' }
--
-- However, note that this will enable a set of default linters,
-- which will cause errors unless these tools are available:
-- {
--   clojure = { "clj-kondo" },
--   dockerfile = { "hadolint" },
--   inko = { "inko" },
--   janet = { "janet" },
--   markdown = { "vale" },
--   rst = { "vale" },
--   ruby = { "ruby" },
--   terraform = { "tflint" },
--   text = { "vale" }
-- }
--
-- You can disable the default linters by setting their filetypes to nil:
-- lint.linters_by_ft['clojure'] = nil
-- lint.linters_by_ft['dockerfile'] = nil
-- lint.linters_by_ft['inko'] = nil
-- lint.linters_by_ft['janet'] = nil
-- lint.linters_by_ft['json'] = nil
-- lint.linters_by_ft['markdown'] = nil
-- lint.linters_by_ft['rst'] = nil
-- lint.linters_by_ft['ruby'] = nil
-- lint.linters_by_ft['terraform'] = nil
-- lint.linters_by_ft['text'] = nil

-- Create autocommand which carries out the actual linting
-- on the specified events.
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		-- Only run the linter in buffers that you can modify in order to
		-- avoid superfluous noise, notably within the handy LSP pop-ups that
		-- describe the hovered symbol using Markdown.
		if vim.bo.modifiable then
			lint.try_lint()
		end
	end,
})

-- snacks
vim.pack.add({ gh("folke/snacks.nvim") })
require("snacks").setup({
	bigfile = { enabled = true },
	image = { enabled = true },
	indent = { enabled = true },
})
