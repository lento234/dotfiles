-- change the default json parser
require("dap.ext.vscode").json_decode = require("json5").parse

-- modify dap ui layout
require("dapui").setup({
  layouts = {
    {
      elements = {
        { id = "scopes",      size = 0.20 },
        { id = "breakpoints", size = 0.20 },
        { id = "stacks",      size = 0.20 },
        { id = "watches",     size = 0.20 },
        { id = "repl",        size = 0.20 },
      },
      -- position = "left",
      position = "right",
      size = 80
    },
    {
      elements = {
        { id = "console", size = 1.0 },
      },
      position = "bottom",
      size = 0.2,
    }
  },
})
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

require('dap-go').setup()

-- require('nvim-dap-projects').search_project_config()
-- require('dap.ext.vscode').load_launchjs(nil, {})
