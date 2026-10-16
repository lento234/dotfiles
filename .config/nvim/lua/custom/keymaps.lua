local map = vim.keymap.set

-- hardmode on
for _, key in ipairs({ "<Left>", "<Right>", "<Up>", "<Down>" }) do
	map({ "n", "v" }, key, "<Nop>")
end

-- remap undo
map("n", "u", "<Nop>")
map("n", "U", "u", { desc = "undo" })

-- move around
map({ "n", "v" }, "H", "^", { desc = "jump to line start" })
map("n", "L", "$", { desc = "jump to line end" })
map("v", "L", "g_", { desc = "select to line end" })

-- deselect all highlights (<C-l> is taken by tmux navigation)
map("n", "<leader><BS>", "<cmd>nohlsearch<CR>", { desc = "clear all highlights" })

-- move lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "move line down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "move line up", silent = true })

-- window
map("n", "<leader>wv", "<C-w>v", { desc = "[w]indow split [v]ertical" })
map("n", "<leader>wh", "<C-w>s", { desc = "[w]indow split [h]orizontal" })
map("n", "<leader>we", "<C-w>=", { desc = "[w]indow [e]qualize" })
map("n", "<leader>wx", "<cmd>close<CR>", { desc = "[w]indow close" })

-- marks
map("n", "<leader>mda", "<cmd>delmarks a-zA-Z0-9<CR>", { desc = "[m]arks: [d]elete [a]ll" })

-- diagnostics
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [q]uickfix list" })
