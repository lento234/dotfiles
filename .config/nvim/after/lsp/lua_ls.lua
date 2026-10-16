-- overrides nvim-lspconfig's lsp/lua_ls.lua (see :h lsp-config-merge)
---@type vim.lsp.Config
return {
	on_init = function(client)
		-- stylua formats Lua; keep conform's LSP fallback from picking lua_ls
		client.server_capabilities.documentFormattingProvider = false

		-- projects with their own .luarc keep their settings; everything else gets Neovim's runtime
		local path = client.workspace_folders and client.workspace_folders[1].name
		if
			path
			and path ~= vim.fn.stdpath("config")
			and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
		then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = { "lua/?.lua", "lua/?/init.lua" },
			},
			workspace = {
				checkThirdParty = false,
				-- only the runtime; indexing every plugin is slow
				library = { vim.env.VIMRUNTIME },
			},
		})
	end,
	settings = {
		Lua = {
			format = { enable = false },
		},
	},
}
