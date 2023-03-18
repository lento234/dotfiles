vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps
keymap.set("n", "<leader><BS>", ":nohl<CR>") -- deselect all highlights
-- keymap.set("n", "<leader>+", "<C-a>") -- increment number
-- keymap.set("n", "<leader>-", "<C-x>") -- decrement number 
keymap.set("n", "j", "ddp") -- move line down
keymap.set("n", "k", "dd<up>P") -- move line up

-- window
keymap.set("n", "<leader>sv", "<C-w>v") -- split vertical
keymap.set("n", "<leader>sh", "<C-w>s") -- split horizontal
keymap.set("n", "<leader>se", "<C-w>=") -- equal the split
keymap.set("n", "<leader>sx", ":close<CR>") -- close split window

-- tab
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- previous tab

-- buffer
keymap.set("n", "<C-q>", ":BufferClose<CR>")

-- plugin: nvim tree
keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>") -- toggle tree

-- plugin: telescope
local builtin = require('telescope.builtin')
keymap.set('n', '<leader><space>', builtin.git_files, {}) -- find files
keymap.set('n', '<leader>ff', builtin.find_files, {}) -- find files
keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- search all
keymap.set('n', '<leader>fb', builtin.buffers, {}) -- search in buffer
keymap.set('n', '<leader>fh', builtin.help_tags, {}) -- search help

-- plugin: nvim lspconfig
-- keymap.set('n', '<leader>e', vim.diagnostic.open_float)

