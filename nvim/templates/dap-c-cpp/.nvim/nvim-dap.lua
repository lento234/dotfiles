local dap = require('dap')

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.fn.stdpath('data') .. '/mason/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'cppdbg',
    request = 'launch',
    program = 'main', -- exeutable binary file
    cwd = '${workspaceFolder}',
    stopOnEntry=false,
    args = {}
  },
}

dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp

