-- Install all plugins
require('plugins.install')

-- Themes
-- vim.cmd([[colorscheme nord]])
-- require('onedark').load()
require('onenord').setup()

-- Initialize plugins
require('lualine').setup()
require('nvim-autopairs').setup()
require('plugins.gitsigns')
require('plugins.treesitter')
require('plugins.nvim-tree')
require('plugins.lsp-zero')
