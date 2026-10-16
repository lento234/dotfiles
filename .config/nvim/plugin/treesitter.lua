local ts = require("nvim-treesitter")

-- ensure basic parsers are installed
ts.install({ "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc" })

---@param buf integer
---@param language string
local function try_attach(buf, language)
	if not vim.treesitter.language.add(language) then
		return
	end
	vim.treesitter.start(buf, language)

	-- treesitter folds, see `:help folds`
	-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	-- vim.wo.foldmethod = 'expr'

	-- without an indent query, keep vim's built-in indentexpr
	if vim.treesitter.query.get(language, "indents") ~= nil then
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
end

local available_parsers = ts.get_available()
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("custom_treesitter", { clear = true }),
	callback = function(args)
		local buf = args.buf
		local language = vim.treesitter.language.get_lang(args.match)
		if not language then
			return
		end

		if vim.tbl_contains(ts.get_installed("parsers"), language) then
			try_attach(buf, language)
		elseif vim.tbl_contains(available_parsers, language) then
			-- auto-install parsers nvim-treesitter knows about, then attach
			ts.install(language):await(function()
				if vim.api.nvim_buf_is_valid(buf) then
					try_attach(buf, language)
				end
			end)
		else
			-- the parser may exist outside nvim-treesitter
			try_attach(buf, language)
		end
	end,
})
