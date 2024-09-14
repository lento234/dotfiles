return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- automatic install lsp
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- shows update status for LSP
    { "j-hui/fidget.nvim", opts = {} },
    -- neodev
    "folke/neodev.nvim",
  },
  config = function()
    -- mason package manger
    require("neodev").setup({
      library = {
        plugins = {
          "nvim-dap-ui"
        },
        types = true,
      }
    })
    require("mason").setup()

    -- [[ Configure LSP]]
    local on_attach = function(client, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end
      -- keymaps
      nmap('K', vim.lsp.buf.hover, 'hover documentation')
      nmap('<M-k>', vim.lsp.buf.signature_help, 'signature documentation')

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
      nmap('<leader>x', vim.diagnostic.open_float, "open float")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })

      -- ruff + pyright
      -- https://github.com/astral-sh/ruff/blob/main/crates/ruff_server/docs/setup/NEOVIM.md
      if client.name == 'ruff' then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
      end
    end

    -- Enable language servers
    local servers = {
      clangd = {},
      gopls = {},
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
      -- prettier = {},
      pyright = {
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { '*' },
            },
          },
        },
      },
      ruff = {},
      -- ruff_lsp = {},
      rust_analyzer = {},
      -- ts/js/vue
      volar = {
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
      }
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

    require('lspconfig').ts_ls.setup {
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vim.fn.expand(
              require("lspconfig.util").path.join("$NVM_BIN/../lib/node_modules", "@vue/typescript-plugin")
            ),
            languages = { "javascript", "typescript", "vue" },
          },
        },
      },
      filetypes = { "javascript", "typescript", "vue" },
    }
  end,
}
