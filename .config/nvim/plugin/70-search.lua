-- snacks.picker (snacks is set up in plugin/20-ui.lua, which also routes vim.ui.select here)
local function map(lhs, picker, desc, mode, opts)
	vim.keymap.set(mode or "n", lhs, function()
		Snacks.picker[picker](opts)
	end, { desc = desc })
end

map("<leader>sh", "help", "[s]earch [h]elp")
map("<leader>sk", "keymaps", "[s]earch [k]eymaps")
map("<leader>sf", "files", "[s]earch [f]iles")
map("<leader>ss", "pickers", "[s]earch [s]elect picker")
map("<leader>sw", "grep_word", "[s]earch current [w]ord", { "n", "x" })
map("<leader>sg", "grep", "[s]earch by [g]rep")
map("<leader>sd", "diagnostics", "[s]earch [d]iagnostics")
map("<leader>sr", "resume", "[s]earch [r]esume")
map("<leader>s.", "recent", '[s]earch Recent Files ("." for repeat)')
map("<leader><leader>", "buffers", "[ ] Find existing buffers")
map("<leader>:", "command_history", "[:] command history")
map('<leader>s"', "registers", '[s]earch ["] registers')
map("<leader>ms", "marks", "[m]arks: [s]how")

-- git
map("<leader>gf", "git_files", "[g]it [f]iles")
map("<leader>gc", "git_log", "[g]it [c]ommits")
map("<leader>gs", "git_status", "[g]it [s]tatus")

map("<leader>/", "lines", "[/] Fuzzily search in current buffer")
map("<leader>s/", "grep_buffers", "[s]earch [/] in Open Files")
