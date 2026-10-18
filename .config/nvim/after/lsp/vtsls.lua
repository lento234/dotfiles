-- overrides nvim-lspconfig's lsp/vtsls.lua (see :h lsp-config-merge)
-- vue_ls only handles the html/css parts of .vue files and forwards TypeScript requests to vtsls
---@type vim.lsp.Config
return {
	-- lspconfig's defaults plus vue
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
	},
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
						languages = { "vue" },
						configNamespace = "typescript",
					},
				},
			},
		},
	},
}
