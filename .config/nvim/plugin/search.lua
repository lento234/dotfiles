local telescope = require("telescope")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")

telescope.setup({
	extensions = {
		["ui-select"] = { themes.get_dropdown() },
	},
})
-- fzf-native is only installed when `make` is available
pcall(telescope.load_extension, "fzf")
telescope.load_extension("ui-select")

local function map(lhs, rhs, desc, mode)
	vim.keymap.set(mode or "n", lhs, rhs, { desc = desc })
end

map("<leader>sh", builtin.help_tags, "[s]earch [h]elp")
map("<leader>sk", builtin.keymaps, "[s]earch [k]eymaps")
map("<leader>sf", builtin.find_files, "[s]earch [f]iles")
map("<leader>ss", builtin.builtin, "[s]earch [s]elect Telescope")
map("<leader>sw", builtin.grep_string, "[s]earch current [w]ord", { "n", "v" })
map("<leader>sg", builtin.live_grep, "[s]earch by [g]rep")
map("<leader>sd", builtin.diagnostics, "[s]earch [d]iagnostics")
map("<leader>sr", builtin.resume, "[s]earch [r]esume")
map("<leader>s.", builtin.oldfiles, '[s]earch Recent Files ("." for repeat)')
map("<leader><leader>", builtin.buffers, "[ ] Find existing buffers")

map("<leader>/", function()
	builtin.current_buffer_fuzzy_find(themes.get_dropdown({ winblend = 10, previewer = false }))
end, "[/] Fuzzily search in current buffer")

map("<leader>s/", function()
	builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
end, "[s]earch [/] in Open Files")
