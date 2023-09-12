-- Install all plugins
require('plugins.install')

-- Themes
-- vim.cmd([[colorscheme nord]])
-- require('onedark').load()
-- require('onenord').setup()
-- require('nightfox').setup({
--   options = {
--     -- Compiled file's destination location
--     styles = {               -- Style to be applied to different syntax groups
--       functions = "bold", -- "NONE",
--       keywords = "bold", --"NONE",
--     },
--   },
-- })

-- setup must be called before loading
-- vim.cmd("colorscheme nordfox")
vim.cmd("colorscheme gruvbox")

-- Initialize plugins
require('lualine').setup()
require('nvim-autopairs').setup()
require('plugins.gitsigns')
require('plugins.treesitter')
require('plugins.nvim-tree')
require('plugins.lsp-zero')
require('plugins.indent-blankline')
-- require('plugins.dap')
require('plugins.telescope')
