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

-- must be registered before vim.pack.add so it sees first installs
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

vim.api.nvim_create_user_command("PackUpdate", function(ev)
	vim.pack.update(#ev.fargs > 0 and ev.fargs or nil, { force = ev.bang })
end, {
	desc = "Update vim.pack plugins",
	bang = true,
	nargs = "*",
	complete = function(arg_lead)
		local names = vim.tbl_map(function(plug)
			return plug.spec.name
		end, vim.pack.get(nil, { info = false }))
		return vim.tbl_filter(function(name)
			return vim.startswith(name, arg_lead)
		end, names)
	end,
})

local function gh(repo)
	return "https://github.com/" .. repo
end

-- a single call installs missing plugins in parallel
local specs = {
	-- ui
	{ src = gh("catppuccin/nvim"), name = "catppuccin" },
	gh("nvim-lualine/lualine.nvim"),
	gh("folke/which-key.nvim"),
	gh("folke/todo-comments.nvim"),
	gh("folke/snacks.nvim"),
	gh("j-hui/fidget.nvim"),
	gh("catgoose/nvim-colorizer.lua"),
	{ src = gh("nvim-neo-tree/neo-tree.nvim"), version = vim.version.range("*") },
	gh("MunifTanjim/nui.nvim"),
	gh("rmagatti/auto-session"),

	-- editor
	gh("nvim-mini/mini.nvim"),
	gh("NMAC427/guess-indent.nvim"),
	gh("folke/flash.nvim"),
	gh("alexghergh/nvim-tmux-navigation"),

	-- git
	gh("lewis6991/gitsigns.nvim"),
	gh("NeogitOrg/neogit"),
	gh("sindrets/diffview.nvim"),

	-- search
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-telescope/telescope-ui-select.nvim"),

	-- completion
	-- release tag downloads the prebuilt fuzzy matcher binary
	{ src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
	gh("rafamadriz/friendly-snippets"),

	-- lsp, formatting, linting
	gh("neovim/nvim-lspconfig"),
	gh("mason-org/mason.nvim"),
	gh("mason-org/mason-lspconfig.nvim"),
	gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
	gh("stevearc/conform.nvim"),
	gh("mfussenegger/nvim-lint"),

	-- treesitter
	{ src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
}
if vim.fn.executable("make") == 1 then
	table.insert(specs, gh("nvim-telescope/telescope-fzf-native.nvim"))
end

vim.pack.add(specs)
