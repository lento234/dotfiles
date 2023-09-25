require("dapui").setup()
require("nvim-dap-virtual-text").setup()

vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>")

vim.keymap.set("n", "<leader>B", ":lua require'dap'.toggle_breakpoint()<CR>")

-- require('dap-python').setup('~/.local/pipx/venvs/python-lsp-server/bin/python')
-- require('dap-python').setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


require('nvim-dap-projects').search_project_config()