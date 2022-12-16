vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps
keymap.set("n", "<leader><BS>", ":nohl<CR>")
-- keymap.set("n", "<leader>nh", ":nohl<CR>")
-- keymap.set("n", "<leader><Space>", ":nohl<CR>")
keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

-- window
keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", ":close<CR>")

-- tab
keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<leader>tn", ":tabn<CR>")
keymap.set("n", "<leader>tp", ":tabp<CR>")

-- plugin: nvim tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- plugin: telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><space>', builtin.find_files, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
