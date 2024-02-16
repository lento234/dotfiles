local keymap = vim.keymap

-- general keymaps
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
-- move around
keymap.set('n', "H", "^")
keymap.set('n', "L", "$")
keymap.set('v', "H", "^")
keymap.set('v', "L", "$<left>")
-- deselect all highlights
keymap.set("n", "<leader><BS>", ":nohl<CR>", { desc = 'clear all highlights' })
-- move lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'move line down' })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'move line up' })
-- toggle line numbers
vim.keymap.set('n', '<C-l>', ":set invrelativenumber<CR>", { desc = 'toggle relative line number' })

-- toggle format on save
vim.keymap.set('n', '<leader>tf', ":call ToggleFormatOnSave()<CR>", { desc = '[t]oggle disable format on save' })

-- window
keymap.set("n", "<leader>sv", "<C-w>v", { desc = '[s]plit [v]ertical' })   -- split vertical
keymap.set("n", "<leader>sh", "<C-w>s", { desc = '[s]plit [h]orizontal' }) -- split horizontal
keymap.set("n", "<leader>se", "<C-w>=", { desc = '[s]plit [e]qual' })      -- equal the split
keymap.set("n", "<leader>sx", ":close<CR>", { desc = '[s]plit close' })    -- close split window

-- tab
keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = '[t]ab [o]pen' })                             -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = '[t]ab e[x]it ' })                          -- close tab
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = '[t]ab [n]ext' })                               -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = '[t]ab [p]revious ' })                          -- previous tab
keymap.set("n", "<leader>tt", ":ToggleTerm direction=float<CR>", { desc = '[t]oggle [t]erminal ' }) -- open terminal

-- plugin: barbar / buffer
-- Move to previous/next
keymap.set("n", "<C-q>", ":BufferClose<CR>", { desc = 'buffer close' })
keymap.set('n', '<A-h>', '<Cmd>BufferPrevious<CR>', { desc = 'buffer prev', noremap = true, silent = true })
keymap.set('n', '<A-l>', '<Cmd>BufferNext<CR>', { desc = 'buffer next', noremap = true, silent = true })
keymap.set('n', '<A-S-h>', '<Cmd>BufferMovePrevious<CR>', { desc = 'buffer move to prev', noremap = true, silent = true })
keymap.set('n', '<A-S-l>', '<Cmd>BufferMoveNext<CR>', { desc = 'buffer move to next', noremap = true, silent = true })

-- Magic buffer-picking mode
keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>', { desc = 'buffer [p]ick', noremap = true, silent = true })
keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>', { desc = 'buffer pin', noremap = true, silent = true })

-- plugin: nvim tree
keymap.set("n", "<leader>n", ":NvimTreeFindFileToggle<CR>", { desc = "tree: show file in [n]vim-tree" }) -- open current file in nvim tree
keymap.set("n", "<leader>tn", ":NvimTreeToggle<CR>", { desc = "tree: [t]oggle [n]vim-tree" })            -- toggle tree

-- plugin: telescope
-- local builtin = require('telescope.builtin')
-- keymap.set('n', '<leader><space>', builtin.git_files, {}) -- find files
-- keymap.set('n', '<leader>ff', builtin.find_files, {}) -- find files
-- keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- search all
-- keymap.set('n', '<leader>fb', builtin.buffers, {}) -- search in buffer
-- keymap.set('n', '<leader>fh', builtin.help_tags, {}) -- search help

keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[<space>] Find existing buffers' })
keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = '[f]ind [g]it files' })
keymap.set('n', '<leader>ff', function()
  require('telescope.builtin').find_files({ hidden = true, ignore = false })
end, { desc = '[f]ind [f]iles' })
keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[f]ind [h]elp' })
keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[f]ind current [w]ord' })
keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = '[f]ind by [k]keymaps' })
keymap.set('n', '<leader>ft', ":TodoTelescope<CR>", { desc = '[f]ind [t]odo' })
keymap.set('n', '<leader>fr', require('telescope.builtin').registers, { desc = '[f]ind [r]egister' })
keymap.set('n', '<leader>gw', require('telescope.builtin').live_grep, { desc = 'live [g]rep [w]ord' })
-- keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })

-- plugin: nvim lspconfig
-- keymap.set('n', '<leader>e', vim.diagnostic.open_float)

-- plugin: harpoon
local harpoon = require("harpoon")

keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "[a]ppend file to harpoon" })
keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
  { desc = "[E]xplore harpoon menulist" })

for i = 1, 9 do
  keymap.set("n", "<A-" .. i .. ">", function() harpoon:list():select(i) end,
    { desc = "Select item [" .. i .. "] in harpoon" })
end
-- vim.keymap.set("n", "<A-k>", function() harpoon:list():prev() end, { desc = "Toggle prev item in harpoon" })
-- vim.keymap.set("n", "<A-j>", function() harpoon:list():next() end, { desc = "Toggle next item in harpoon" })

-- dap
keymap.set('n', '<F5>', function()
  require('dap.ext.vscode').load_launchjs(nil, {})
  require('dap').continue()
end, { desc = 'dap: continue (or start + load launch json)' })
keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'dap: step over' })
keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'dap: step into' })
keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = 'dap: step out' })

-- vim.keymap.set("n", "<leader>bb", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = 'DAP: [bb] Toggle breakpoint' })
-- vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'dap: toggle [b]reakpoint' })
-- vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
--   { desc = 'dap: set [B]reakpoint condition' })

-- Save breakpoints to file automatically.
vim.keymap.set("n", "<leader>b", function() require("persistent-breakpoints.api").toggle_breakpoint() end,
  { desc = "dap: toggle [b]reakpoint" })
vim.keymap.set("n", "<leader>B", function() require("persistent-breakpoints.api").set_conditional_breakpoint() end,
  { desc = "dap: set conditional [B]reakpoint" })
vim.keymap.set("n", "<leader>dcb", function() require("persistent-breakpoints.api").clear_all_breakpoints() end,
  { desc = "[d]ap: [c]lear all [b]reakpoints" })

vim.keymap.set('n', '<leader>do', function() require('dapui').open() end, { desc = '[d]ap: [o]pen' })
vim.keymap.set('n', '<leader>dC', function() require('dapui').close() end, { desc = '[d]ap: [C]lose' })
vim.keymap.set('n', '<leader>dr', function() require('dap').restart() end, { desc = '[d]ap: [r]estart session' })
vim.keymap.set('n', '<leader>dx', function() require('dap').terminate() end, { desc = '[d]ap: e[x]it session' })
vim.keymap.set('n', '<leader>dl', function() require('dap.ext.vscode').load_launchjs(nil, {}) end,
  { desc = '[d]ap: start debug using vscode [l]aunch.json' })
vim.keymap.set('n', '<leader>df', ":Telescope dap frames<CR>", { desc = '[d]ap: telescope list [f]rames' })
vim.keymap.set('n', '<leader>db', ":Telescope dap list_breakpoints<CR>", { desc = '[d]ap: telescope list [b]reakpoints' })

vim.keymap.set('n', '<M-k>', function() require('dapui').eval() end, { desc = 'dap: [k]eval' })

-- neogit
keymap.set('n', '<leader>gg', ':Neogit<CR>', { desc = '[g]o launch neo[g]it' })

-- colorizer
keymap.set('n', '<leader>tc', ':Lazy load nvim-colorizer.lua<CR>:ColorizerToggle<CR>', { desc = '[t]oggle [c]olorized' })

-- trouble
-- Lua
keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, { desc = "[x]trouble: [x]toggle" })
keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end,
  { desc = "[x]trouble: [w]orkspace" })
keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,
  { desc = "[x]trouble: [d]iagnostics" })
keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, { desc = "[x]trouble: [q]uickfix" })
keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end, { desc = "[x]trouble: [l]oclist" })
-- keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end, { desc = "[x]trouble: [x]toggle" })

-- auto-session
keymap.set("n", "<leader>ss", ":SessionSave<CR>", { desc = "[s]session: [s]ave" })
keymap.set("n", "<leader>sd", ":SessionDelete<CR>", { desc = "[s]session: [d]elete" })
keymap.set("n", "<leader>sr", ":SessionRestore<CR>", { desc = "[s]session: [r]estore" })
