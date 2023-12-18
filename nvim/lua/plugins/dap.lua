require("dapui").setup()
require("nvim-dap-virtual-text").setup()

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

dap.adapters.python = {
    type = 'executable',
    command = vim.fn.stdpath('data') .. '/mason/bin/debugpy-adapter',
    options = {
        source_filetype = 'python',
    }
}


-- require('nvim-dap-projects').search_project_config()
require('dap.ext.vscode').load_launchjs(nil, {})
