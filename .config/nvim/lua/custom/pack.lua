-- must be registered before vim.pack.add so it sees first installs
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind ~= "install" and kind ~= "update" then
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
	gh("romgrk/barbar.nvim"),
	gh("folke/which-key.nvim"),
	gh("folke/todo-comments.nvim"),
	gh("folke/snacks.nvim"),
	gh("j-hui/fidget.nvim"),
	gh("catgoose/nvim-colorizer.lua"),
	{ src = gh("nvim-neo-tree/neo-tree.nvim"), version = vim.version.range("*") },
	gh("MunifTanjim/nui.nvim"),
	gh("rmagatti/auto-session"),
	gh("OXY2DEV/markview.nvim"),

	-- editor
	gh("nvim-mini/mini.nvim"),
	gh("NMAC427/guess-indent.nvim"),
	gh("folke/flash.nvim"),
	gh("alexghergh/nvim-tmux-navigation"),

	-- git
	gh("lewis6991/gitsigns.nvim"),
	gh("NeogitOrg/neogit"),
	gh("sindrets/diffview.nvim"),

	-- neogit and diffview dependency
	gh("nvim-lua/plenary.nvim"),

	-- completion
	-- release tag downloads the prebuilt fuzzy matcher binary
	{ src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
	gh("rafamadriz/friendly-snippets"),

	-- lsp, formatting, linting
	gh("neovim/nvim-lspconfig"),
	gh("folke/lazydev.nvim"),
	gh("mason-org/mason.nvim"),
	gh("mason-org/mason-lspconfig.nvim"),
	gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
	gh("stevearc/conform.nvim"),
	gh("mfussenegger/nvim-lint"),

	-- treesitter
	{ src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },

	-- ai
	gh("folke/sidekick.nvim"),
}

vim.pack.add(specs)
