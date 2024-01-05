-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  local opts = { buffer = bufnr, remap = false }
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>q', "<cmd>Telescope diagnostics<cr>", opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  --   K: Displays hover information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.hover().
  --   gd: Jumps to the definition of the symbol under the cursor. See :help vim.lsp.buf.definition().
  --   gD: Jumps to the declaration of the symbol under the cursor. Some servers don't implement this feature. See :help vim.lsp.buf.declaration().
  --   gi: Lists all the implementations for the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.implementation().
  --   go: Jumps to the definition of the type of the symbol under the cursor. See :help vim.lsp.buf.type_definition().
  --   gr: Lists all the references to the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.references().
  --   gs: Displays signature information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.signature_help(). If a mapping already exists for this key this function is not bound.
  --   <F2>: Renames all references to the symbol under the cursor. See :help vim.lsp.buf.rename().
  --   <F3>: Format code in current buffer. See :help vim.lsp.buf.format().
  --   <F4>: Selects a code action available at the current cursor position. See :help vim.lsp.buf.code_action().
  --   gl: Show diagnostics in a floating window. See :help vim.diagnostic.open_float().
  --   [d: Move to the previous diagnostic in the current buffer. See :help vim.diagnostic.goto_prev().
  --   ]d: Move to the next diagnostic. See :help vim.diagnostic.goto_next().
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

local cmp = require('cmp')
local cmp_format = lsp_zero.cmp_format()
-- local cmp_action = lsp_zero.cmp_action()

cmp.setup({
  formatting = cmp_format,
  mapping = cmp.mapping.preset.insert({
    -- scroll up and down the documentation window
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    -- ['<Tab>'] = cmp_action.luasnip_supertab(),
    -- ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  }),
  -- sources = {
  --   { name = 'path' },
  --   { name = 'buffer' }
  -- }
})

-- -- python
-- require'lspconfig'.pylsp.setup{
--   settings = {
--     pylsp = {
--       plugins = {
--         pycodestyle = {
--           maxLineLength = 88
--         }
--       }
--     }
--   }
-- }
