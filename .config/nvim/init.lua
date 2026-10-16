-- faster startup by caching
vim.loader.enable()

require("custom.opts")
require("custom.keymaps")
require("custom.autocmds")
-- installs and adds all plugins; their setup lives in plugin/*.lua
require("custom.pack")
