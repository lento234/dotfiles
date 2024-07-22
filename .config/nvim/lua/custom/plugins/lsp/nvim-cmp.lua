return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- snippet engine
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		-- add lsp completion
		"hrsh7th/nvim-cmp",
		-- "hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		-- user friendly snippets
		"rafamadriz/friendly-snippets",
		-- vscode like pictograms
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		require("luasnip.loaders.from_vscode").lazy_load()
		luasnip.config.setup()

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = {
				completeopts = "menu,menuone,noinsert",
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				-- ['<C-p>'] = cmp.mapping.select_prev_item(),
				["<C-p>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete({}),
				-- ['<CR>'] = cmp.mapping.confirm {
				--   behavior = cmp.ConfirmBehavior.Replace,
				--   select = true,
				-- },
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				-- { name = "buffer" },
				{ name = "path" },
			},
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}
