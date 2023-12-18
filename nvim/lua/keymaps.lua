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
keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = '[t]ab [o]pen' }) -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = '[t]ab e[x]it '}) -- close tab
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = '[t]ab [n]ext' })     -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = '[t]ab [p]revious ' }) -- previous tab
keymap.set("n", "<leader>tt", ":ToggleTerm direction=float<CR>", { desc = '[t]oggle [t]erminal ' }) -- open terminal

-- keymap.set("n", "<leader>bn", ":BufferNext<CR>")     -- next tab
-- keymap.set("n", "<leader>bp", ":BufferPrevious<CR>")     -- previous tab

-- buffer
keymap.set("n", "<C-q>", ":BufferClose<CR>")

-- plugin: nvim tree
keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>") -- toggle tree

-- barbar
-- Move to previous/next
-- keymap.set('n',  '<A-,>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
-- keymap.set('n',  '<A-.>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
keymap.set('n',  '<A-h>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
keymap.set('n',  '<A-l>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
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

-- harpoon
local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "[A]ppend file to harpoon" })
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[E]xplore harpoon menulist" })
vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end, { desc = "Select item [1] in harpoon" })
vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end, { desc = "Select item [2] in harpoon" })
vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end, { desc = "Select item [3] in harpoon" })
vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end, { desc = "Select item [4] in harpoon" })
vim.keymap.set("n", "<A-k>", function() harpoon:list():prev() end, { desc = "Toggle prev item in harpoon" })
vim.keymap.set("n", "<A-j>", function() harpoon:list():next() end, { desc = "Toggle next item in harpoon" })

-- dap

vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F12>", ":lua require'dap'.step_into()<CR>")

vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'dap: continue' })
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'dap: step over' })
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'dap: step into' })
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = 'dap: step out' })

-- vim.keymap.set("n", "<leader>bb", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = 'DAP: [bb] Toggle breakpoint' })
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'dap: toggle [b]reakpoint' })
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end, { desc = 'dap: set [B]reakpoint ' })
-- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, { desc = 'DAP: [d]ap [r]epl open' })
vim.keymap.set('n', '<Leader>dr', function() require('dap').restart() end, { desc = '[d]ap: [r]estart session' })
vim.keymap.set('n', '<Leader>dx', function() require('dap').terminate() end, { desc = '[d]ap: e[x]it' })
vim.keymap.set('n', '<Leader>dl', function() require('dap.ext.vscode').load_launchjs(nil, {}) end, { desc = '[d]ap: start debug using vscode [l]aunch.json' })

