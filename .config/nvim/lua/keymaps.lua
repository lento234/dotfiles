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
noremap("n", "<C-l>", ":set invrelativenumber<CR>", "toggle relative line number")

-- toggle format on save
noremap("n", "<leader>tf", ":ToggleFormatOnSave<CR>", "[t]oggle disable format on save")

-- window
noremap("n", "<leader>sv", "<C-w>v", "[s]plit [v]ertical")   -- split vertical
noremap("n", "<leader>sh", "<C-w>s", "[s]plit [h]orizontal") -- split horizontal
noremap("n", "<leader>se", "<C-w>=", "[s]plit [e]qual")      -- equal the split
noremap("n", "<leader>sx", ":close<CR>", "[s]plit close")    -- close split window

-- tab
noremap("n", "<leader>to", ":tabnew<CR>", "[t]ab [o]pen")    -- open new tab
noremap("n", "<leader>tx", ":tabclose<CR>", "[t]ab e[x]it ") -- close tab
noremap("n", "<leader>tn", ":tabn<CR>", "[t]ab [n]ext")      -- next tab
noremap("n", "<leader>tp", ":tabp<CR>", "[t]ab [p]revious ") -- previous tab

-- terminal
noremap("n", "<leader>tt", ":ToggleTerm direction=float<CR>", "terminal: [t]oggle [t]erminal") -- open terminal
noremap("t", "<esc>", [[<C-\><C-n>]], "terminal: escape to normal mode")                       -- Enter normal mode while in a terminal

-- plugin: barbar / buffer
-- Move to previous/next
noremap("n", "<C-q>", ":BufferClose<CR>", "buffer close")
noremap("n", "<A-h>", "<Cmd>BufferPrevious<CR>", "buffer prev")
noremap("n", "<A-l>", "<Cmd>BufferNext<CR>", "buffer next")
noremap("n", "<A-H>", "<Cmd>BufferMovePrevious<CR>", "buffer move to prev")
noremap("n", "<A-L>", "<Cmd>BufferMoveNext<CR>", "buffer move to next")

-- Magic buffer-picking mode
noremap("n", "<C-p>", "<Cmd>BufferPick<CR>", "buffer [p]ick")
noremap("n", "<A-p>", "<Cmd>BufferPin<CR>", "buffer pin")

-- plugin: nvim tree
noremap("n", "<leader>n", ":NvimTreeFindFileToggle<CR>", "tree: show file in [n]vim-tree") -- open current file in nvim tree
noremap("n", "<leader>tn", ":NvimTreeToggle<CR>", "tree: [t]oggle [n]vim-tree")            -- toggle tree

-- plugin: telescope
noremap("n", "<leader>?", require("telescope.builtin").oldfiles, "telescope: [?] Find recently opened files")
noremap("n", "<leader><space>", require("telescope.builtin").buffers, "telescope: [<space>] Find existing buffers")
noremap("n", "<leader>/",
  function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, "telescope: [/] Fuzzily search in current buffer")
noremap("n", "<leader>fg", require("telescope.builtin").git_files, "telescope: [f]ind [g]it files")
noremap("n", "<leader>ff",
  function()
    require("telescope.builtin").find_files({ hidden = true, ignore = false })
  end, "telescope: [f]ind [f]iles")
noremap("n", "<leader>fh", require("telescope.builtin").help_tags, "telescope: [f]ind [h]elp")
noremap("n", "<leader>fw",
  function()
    require("telescope.builtin").live_grep({ additional_args = { "--hidden" } })
  end, "telescope: [f]ind [w]ord")
noremap("n", '<leader>fs', require('telescope.builtin').lsp_document_symbols, "telescope: [f]ind document [s]ymbols")
noremap("n", '<leader>fk', require('telescope.builtin').keymaps, "telescope: [f]ind by [k]keymaps")
noremap("n", '<leader>ft', ":TodoTelescope<CR>", "telescope: [f]ind [t]odo")
noremap("n", '<leader>fr', require('telescope.builtin').registers, "telescope: [f]ind [r]egister")
noremap("n", '<leader>gw', require('telescope.builtin').grep_string, "telescope: [g]rep current [w]ord")
-- keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })

-- plugin: nvim lspconfig
-- keymap.set('n', '<leader>e', vim.diagnostic.open_float)

-- plugin: harpoon
local harpoon = require("harpoon")

noremap("n", "<leader>a", function() harpoon:list():append() end, "harpoon: [a]ppend file")
noremap("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "harpoon: open [e]xplore menulist")

for i = 1, 9 do
  noremap("n", "<A-" .. i .. ">", function() harpoon:list():select(i) end, "harpoon: select item [" .. i .. "]")
end

-- plugin: dap
noremap("n", "<F5>",
  function()
    require("dap.ext.vscode").load_launchjs(nil, {})
    require("dap").continue()
  end, "dap: continue (or start + load launch json)")
noremap("n", "<F10>", function() require("dap").step_over() end, "dap: step over")
noremap("n", "<F11>", function() require("dap").step_into() end, "dap: step into")
noremap("n", "<F12>", function() require("dap").step_out() end, "dap: step out")
-- save breakpoints to file automatically.
noremap("n", "<leader>b", function() require("persistent-breakpoints.api").toggle_breakpoint() end,
  "dap: toggle [b]reakpoint")
noremap("n", "<leader>B", function() require("persistent-breakpoints.api").set_conditional_breakpoint() end,
  "dap: set conditional [B]reakpoint")
noremap("n", "<leader>dcb", function() require("persistent-breakpoints.api").clear_all_breakpoints() end,
  "[d]ap: [c]lear all [b]reakpoints")

noremap("n", "<leader>do", function() require("dapui").open() end, "[d]ap: [o]pen")
noremap("n", "<leader>dC", function() require("dapui").close() end, "[d]ap: [C]lose")
noremap("n", "<leader>dr", function() require("dap").restart() end, "[d]ap: [r]estart session")
noremap("n", "<leader>dx", function() require("dap").terminate() end, "[d]ap: e[x]it session")
noremap("n", "<leader>dl", function() require("dap.ext.vscode").load_launchjs(nil, {}) end,
  "[d]ap: start debug using vscode [l]aunch.json")
noremap("n", "<leader>df", ":Telescope dap frames<CR>", "[d]ap: telescope list [f]rames")
noremap("n", "<leader>db", ":Telescope dap list_breakpoints<CR>", "[d]ap: telescope list [b]reakpoints")
-- dapui
noremap("n", "<M-k>", function() require("dapui").eval() end, "dap: [k]eval")

-- plugin: neogit
noremap("n", "<leader>gg", ":Neogit<CR>", "[g]o launch neo[g]it")

-- plugin: colorizer
noremap("n", "<leader>tc", ":Lazy load nvim-colorizer.lua<CR>:ColorizerToggle<CR>", "[t]oggle [c]olorized",
  { silent = false })

-- plugin: trouble
noremap("n", "<leader>xx", function() require("trouble").toggle() end, "[x]trouble: [x]toggle")
noremap("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, "[x]trouble: [w]orkspace")
noremap("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, "[x]trouble: [d]iagnostics")
noremap("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, "[x]trouble: [q]uickfix")
noremap("n", "<leader>xl", function() require("trouble").toggle("loclist") end, "[x]trouble: [l]oclist")
-- keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end, { desc = "[x]trouble: [x]toggle" })

-- plugin: auto-session
noremap("n", "<leader>ss", ":SessionSave<CR>", "[s]session: [s]ave")
noremap("n", "<leader>sd", ":SessionDelete<CR>", "[s]session: [d]elete")
noremap("n", "<leader>sr", ":SessionRestore<CR>", "[s]session: [r]estore")
