-- server configs come from nvim-lspconfig's lsp/*.lua, overridden in after/lsp/*.lua
local servers = {
	"clangd",
	"eslint",
	"gopls",
	"lua_ls",
	"pyright",
	"ruff", -- also used by conform
	"rust_analyzer",
	"stylua",
	"vtsls", -- also serves TypeScript inside .vue files, see after/lsp/vtsls.lua
	"vue_ls",
}

-- Neovim/plugin types for lua_ls, only in Lua files that need them
require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ path = "snacks.nvim", words = { "Snacks" } },
	},
})

require("mason").setup({})
-- only used for lspconfig <-> mason name translation; servers are enabled below
require("mason-lspconfig").setup({ automatic_enable = false })
require("mason-tool-installer").setup({
	ensure_installed = vim.list_extend(vim.deepcopy(servers), {
		"jsonlint", -- nvim-lint
		"markdownlint", -- nvim-lint
		"prettier", -- conform
		"clang-format", -- conform
	}),
})

-- zls has to match the zig version, so it comes from PATH instead of mason;
-- servers whose binary is missing are skipped quietly
vim.lsp.enable(vim.list_extend(vim.deepcopy(servers), { "zls" }))

-- grn, gra, grr, gri, grt and gO are nvim defaults; the pickers below override some with snacks
local highlight_augroup = vim.api.nvim_create_augroup("custom_lsp_highlight", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("custom_lsp_attach", { clear = true }),
	callback = function(event)
		local buf = event.buf
		local function map(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = "LSP: " .. desc })
		end
		local function pick(lhs, picker, desc)
			map(lhs, function()
				Snacks.picker[picker]()
			end, desc)
		end

		pick("grr", "lsp_references", "[g]oto [r]eferences")
		pick("gri", "lsp_implementations", "[g]oto [i]mplementation")
		pick("grd", "lsp_definitions", "[g]oto [d]efinition")
		pick("grt", "lsp_type_definitions", "[g]oto [t]ype definition")
		pick("grD", "lsp_declarations", "[g]oto [D]eclaration")
		pick("gO", "lsp_symbols", "document symbols")
		pick("gW", "lsp_workspace_symbols", "workspace symbols")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client then
			return
		end

		-- nvim only maps K to hover when 'keywordprg' is untouched, and some ftplugins
		-- set it (go runs `go doc` in a terminal split), so map it explicitly
		if client:supports_method("textDocument/hover", buf) then
			map("K", vim.lsp.buf.hover, "hover documentation")
		end
		if client:supports_method("textDocument/signatureHelp", buf) then
			map("<M-k>", vim.lsp.buf.signature_help, "signature documentation")
		end
		map("<leader>lr", "<cmd>lsp restart<CR>", "[l]sp [r]estart")

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
