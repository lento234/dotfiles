-- overrides nvim-lspconfig's lsp/lua_ls.lua (see :h lsp-config-merge)
-- Neovim runtime and plugin types come from lazydev, see plugin/40-lsp.lua
---@type vim.lsp.Config
return {
	on_init = function(client)
		-- stylua formats Lua; keep conform's LSP fallback from picking lua_ls
		client.server_capabilities.documentFormattingProvider = false
	end,
	settings = {
		Lua = {
			format = { enable = false },
		},
	},
}
