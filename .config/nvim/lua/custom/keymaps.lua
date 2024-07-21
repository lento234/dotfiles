local function noremap(mode, lhs, rhs, desc, opts)
	opts = opts or { silent = true }
	vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true, silent = opts["silent"] })
end

-- general keymaps
-- hardmode on
noremap("n", "<Left>", "", "")
noremap("n", "<Right>", "", "")
noremap("n", "<Up>", "", "")
noremap("n", "<Down>", "", "")
noremap("v", "<Left>", "", "")
noremap("v", "<Right>", "", "")
noremap("v", "<Up>", "", "")
noremap("v", "<Down>", "", "")

-- remap undo
noremap("n", "u", "")
noremap("n", "U", ":u<CR>", "undo")

-- move around
noremap("n", "H", "^", "jump to line start")
noremap("n", "L", "$", "jump to line end")
noremap("v", "H", "^", "select to line start")
noremap("v", "L", "$<left>", "select to line end")

-- deselect all highlights
noremap("n", "<leader><BS>", ":nohl<CR>", "clear all highlights")

-- move lines
noremap("v", "J", ":m '>+1<CR>gv=gv", "move line down")
noremap("v", "K", ":m '<-2<CR>gv=gv", "move line up")

-- toggle line numbers
noremap("n", "<leader>tl", ":set invrelativenumber<CR>", "[t]oggle relative [l]ine number")

-- toggle format on save
noremap("n", "<leader>tf", ":ToggleFormatOnSave<CR>", "[t]oggle disable [f]ormat on save")

-- window
noremap("n", "<leader>sv", "<C-w>v", "[s]plit [v]ertical")   -- split vertical
noremap("n", "<leader>sh", "<C-w>s", "[s]plit [h]orizontal") -- split horizontal
noremap("n", "<leader>se", "<C-w>=", "[s]plit [e]qual")      -- equal the split
noremap("n", "<leader>sx", ":close<CR>", "[s]plit close")    -- close split window

-- tab
-- noremap("n", "<leader>to", ":tabnew<CR>", "[t]ab [o]pen")    -- open new tab
-- noremap("n", "<leader>tx", ":tabclose<CR>", "[t]ab e[x]it ") -- close tab
-- noremap("n", "<leader>tn", ":tabn<CR>", "[t]ab [n]ext")      -- next tab
-- noremap("n", "<leader>tp", ":tabp<CR>", "[t]ab [p]revious ") -- previous tab
