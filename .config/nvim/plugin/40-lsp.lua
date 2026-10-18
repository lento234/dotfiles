-- server configs come from nvim-lspconfig's lsp/*.lua, overridden in after/lsp/*.lua
local servers = { "lua_ls", "stylua" }

require("mason").setup({})
-- only used for lspconfig <-> mason name translation; servers are enabled below
require("mason-lspconfig").setup({ automatic_enable = false })
require("mason-tool-installer").setup({
	ensure_installed = vim.list_extend(vim.deepcopy(servers), {
		"jsonlint", -- nvim-lint
		"markdownlint", -- nvim-lint
		"prettier", -- conform
		"clang-format", -- conform
		"ruff", -- conform
	}),
})

vim.lsp.enable(servers)

-- grn, gra, grr, gri, grt and gO are nvim defaults; the pickers below override some with telescope
local highlight_augroup = vim.api.nvim_create_augroup("custom_lsp_highlight", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("custom_lsp_attach", { clear = true }),
	callback = function(event)
		local buf = event.buf
		local builtin = require("telescope.builtin")
		local function map(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = "LSP: " .. desc })
		end

		map("grr", builtin.lsp_references, "[g]oto [r]eferences")
		map("gri", builtin.lsp_implementations, "[g]oto [i]mplementation")
		map("grd", builtin.lsp_definitions, "[g]oto [d]efinition")
		map("grt", builtin.lsp_type_definitions, "[g]oto [t]ype definition")
		map("grD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
		map("gO", builtin.lsp_document_symbols, "document symbols")
		map("gW", builtin.lsp_dynamic_workspace_symbols, "workspace symbols")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client then
			return
		end

		-- highlight references of the word under the cursor while it rests there
		if client:supports_method("textDocument/documentHighlight", buf) then
			vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = buf })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})
		end

		if client:supports_method("textDocument/inlayHint", buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }))
			end, "[t]oggle inlay [h]ints")
		end
	end,
})

vim.api.nvim_create_autocmd("LspDetach", {
	group = vim.api.nvim_create_augroup("custom_lsp_detach", { clear = true }),
	callback = function(event)
		vim.lsp.buf.clear_references()
		vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = event.buf })
	end,
})
