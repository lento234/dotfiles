-- mason package manger
require("neodev").setup()
require("mason").setup()

-- [[ Configure LSP]]
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  -- keymaps
  nmap('K', vim.lsp.buf.hover, 'hover documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'signature documentation')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[g]oto [d]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
  nmap('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[g]oto [I]mplementation')
  -- nmap('gI', vim.lsp.buf.implementation, '[g]oto [I]mplementation')

  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[d]ocument [s]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction')
  nmap('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
  nmap('<leader>q', "<cmd>Telescope diagnostics<cr>", 'diagnostics')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable language servers
local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

-- autocompletion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- setup lsp
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})
mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    })
  end,
})

-- [[ Configure nvim-cmp ]]
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopts = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
})
