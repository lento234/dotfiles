return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- automatic install lsp
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- shows update status for LSP
    { "j-hui/fidget.nvim",    opts = {} },
  },
  config = function()
    -- [[ Configure LSP]]
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        -- keymaps
        -- documentation
        map("K", vim.lsp.buf.hover, "hover documentation")
        map("<M-k>", vim.lsp.buf.signature_help, "signature documentation")
        -- rename the variable
        map("grn", vim.lsp.buf.rename, "[g]oto [r]e[n]ame")
        -- execute a code action or a suggestion from your LSP
        map('gra', vim.lsp.buf.code_action, '[g]oto code [a]ction', { "n", "x" })
        -- find reference for word
        map("gri", require("fzf-lua").lsp_implementations, "[g]oto [i]mplementation")
        -- nmap('gI', vim.lsp.buf.implementation, '[g]oto [I]mplementation')
        -- jump to definitions, jump back with <C-t>
        map("grd", require("fzf-lua").lsp_definitions, "[g]oto [d]efinition")
        -- jump to declaration
        map("grD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
        -- jump to symbols in current document (variables, functions, types, ...)
        map("gO", require("fzf-lua").lsp_document_symbols, "[g]oto [d]ocument [s]ymbols")
        -- jump to all symbols in your workspace
        map("gW", require("fzf-lua").lsp_workspace_symbols, "[g]oto [w]orkspace [s]ymbols")
        -- jump to type of the work under you curosor
        map("grt", require("fzf-lua").lsp_typedefs, "[g]oto [t]ype definition")

        -- jump to references
        map("grr", require("fzf-lua").lsp_references, "[g]oto [r]eferences")
        --   nmap('<leader>q', require('fzf-lua').lsp_document_diagnostics, 'diagnostics')
        --   nmap('<leader>x', vim.diagnostic.open_float, "open float")
        --
        --   -- Create a command `:Format` local to the LSP buffer
        --   vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        --     vim.lsp.buf.format()
        --   end, { desc = 'Format current buffer with LSP' })
        --
        --   -- ruff + pyright
        --   -- https://github.com/astral-sh/ruff/blob/main/crates/ruff_server/docs/setup/NEOVIM.md
        --   if client.name == 'ruff' then
        --     -- Disable hover in favor of Pyright
        --     client.server_capabilities.hoverProvider = false
        --   end
        --


        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client then
          local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- Enable language servers
    local servers = {
      clangd = {},
      debugpy = {},
      eslint = {},
      glsl_analyzer = {},
      gopls = {},
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
      prettier = {},
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
      rust_analyzer = {},
      stylua = {},
      -- ts/js/vue
      ts_ls = {},
      vue_ls = {},
      zls = {},
    }

    -- autocompletion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    require("mason-lspconfig").setup()

    -- setup lsp
    -- Ensure the servers and tools above are installed
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua", -- format lua code
    })

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }
    require("mason-lspconfig").setup({
      ensure_installed = {},
      automatic_enable = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      }
    })
    vim.lsp.enable('vue_ls')
    local vue_language_server_path = table.concat({ "$NVM_BIN/../lib/node_modules", "@vue/typescript-plugin" })
    require('lspconfig').ts_ls.setup {
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_language_server_path,
            languages = { "vue", "javascript", "typescript" },
          },
        },
      },
      filetypes = { 'typescript', 'javascript', 'vue' },
    }
    --
    -- vim.lsp.config('vue_ls', {
    --   -- add filetypes for typescript, javascript and vue
    --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    --   init_options = {
    --     vue = {
    --       -- disable hybrid mode
    --       hybridMode = false,
    --     },
    --   },
    -- })
  end,
}
