vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps
keymap.set("n", "<leader><BS>", ":nohl<CR>") -- deselect all highlights
-- keymap.set("n", "<leader>+", "<C-a>") -- increment number
-- keymap.set("n", "<leader>-", "<C-x>") -- decrement number
-- keymap.set("n", "j", "ddp") -- move line down
-- keymap.set("n", "k", "dd<up>P") -- move line up
keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv") -- move line down
keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv") -- move line up

-- line numbers
vim.keymap.set('n', '<C-l>', ":set invrelativenumber<CR>")

-- window
keymap.set("n", "<leader>sv", "<C-w>v")     -- split vertical
keymap.set("n", "<leader>sh", "<C-w>s")     -- split horizontal
keymap.set("n", "<leader>se", "<C-w>=")     -- equal the split
keymap.set("n", "<leader>sx", ":close<CR>") -- close split window

-- tab
keymap.set("n", "<leader>to", ":tabnew<CR>")   -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close tab
keymap.set("n", "<leader>tn", ":tabn<CR>")     -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>")     -- previous tab

keymap.set("n", "<leader>bn", ":BufferNext<CR>")     -- next tab
keymap.set("n", "<leader>bp", ":BufferPrevious<CR>")     -- previous tab

-- buffer
keymap.set("n", "<C-q>", ":BufferClose<CR>")

-- plugin: nvim tree
keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>") -- toggle tree

-- barbar
-- Move to previous/next
keymap.set('n',  '<A-,>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
keymap.set('n',  '<A-.>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
-- Magic buffer-picking mode
keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>', { noremap = true, silent = true })
-- plugin: telescope
-- local builtin = require('telescope.builtin')
-- keymap.set('n', '<leader><space>', builtin.git_files, {}) -- find files
-- keymap.set('n', '<leader>ff', builtin.find_files, {}) -- find files
-- keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- search all
-- keymap.set('n', '<leader>fb', builtin.buffers, {}) -- search in buffer
-- keymap.set('n', '<leader>fh', builtin.help_tags, {}) -- search help

keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Find [G]it [F]iles' })
keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
-- keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })

-- plugin: nvim lspconfig
-- keymap.set('n', '<leader>e', vim.diagnostic.open_float)

-- hardmode on
keymap.set('n', "<Left>", "")
keymap.set('n', "<Right>", "")
keymap.set('n', "<Up>", "")
keymap.set('n', "<Down>", "")

keymap.set('v', "<Left>", "")
keymap.set('v', "<Right>", "")
keymap.set('v', "<Up>", "")
keymap.set('v', "<Down>", "")

-- remap undo
keymap.set('n', "u", "")
keymap.set('n', "U", ":u<CR>")
