-- overrides nvim-lspconfig's lsp/pyright.lua (see :h lsp-config-merge)
-- ruff handles linting and import sorting; pyright only provides types, hover and navigation
---@type vim.lsp.Config
return {
	settings = {
		pyright = {
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				-- ignore all files for analysis so diagnostics come from ruff only
				ignore = { "*" },
			},
		},
	},
}
