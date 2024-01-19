-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- colorscheme
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- load the colorscheme here
            require("gruvbox").setup({
                contrast = "hard",
                overrides = {
                    SignColumn = { bg = "#1d2021" },
                    TabLineFill = { bg = "#1d2021" },
                    TabLineSel = { bg = "#1d2021" },
                },
            })
            vim.cmd("colorscheme gruvbox")
        end,
    },
    -- status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {},
    },
    -- indent lines
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = { enabled = false },
        },
    },
    -- open buffer bar
    {
        "romgrk/barbar.nvim",
        dependencies = { "nvim-web-devicons" },
        opts = {},
    },
    -- file explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("nvim-tree").setup({
                renderer = {
                    icons = {
                        glyphs = {
                            folder = {
                                arrow_closed = "",
                                arrow_open = "",
                            },
                        },
                    },
                },
            })
        end,
    },
    -- alpha: greeter for neovim
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("alpha").setup(require("alpha.themes.startify").config)
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    -- telescope for file, search, ...
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
    },
    -- Useful plugin to show you pending keybinds.
    {
        "folke/which-key.nvim",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    },
    -- treesitter
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    -- terminal
    {
        "akinsho/toggleterm.nvim",
        version = '*',
        opts = {},
    },
    -- markdown viewer
    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        opts = {
            width = 200,
        }
    },
    -- another markdown preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    -- commenting (gcc, gcap)
    -- "tpope/vim-commentary",
    {
        "numToStr/Comment.nvim",
        opts = {},
    },
    -- auto closing
    { "windwp/nvim-autopairs", opts = {} },
    -- surround
    "tpope/vim-surround",
    -- whitespace
    "ntpeters/vim-better-whitespace",
    -- tabstop and shiftwidth automatically
    "tpope/vim-sleuth",

    -- git plugins
    "tpope/vim-fugitive",
    -- Git diff view
    "sindrets/diffview.nvim",
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map({ 'n', 'v' }, ']c', function()
                    if vim.wo.diff then
                        return ']c'
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Jump to next hunk' })

                map({ 'n', 'v' }, '[c', function()
                    if vim.wo.diff then
                        return '[c'
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Jump to previous hunk' })

                -- Actions
                -- visual mode
                map('v', '<leader>hs', function()
                    gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end, { desc = 'stage git hunk' })
                map('v', '<leader>hr', function()
                    gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end, { desc = 'reset git hunk' })
                -- normal mode
                map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
                map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
                map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
                map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
                map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
                map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
                map('n', '<leader>hb', function()
                    gs.blame_line { full = false }
                end, { desc = 'git blame line' })
                map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
                map('n', '<leader>hD', function()
                    gs.diffthis '~'
                end, { desc = 'git diff against last commit' })

                -- Toggles
                map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
                map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

                -- Text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
            end,
        },
    },

    -- harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    -- LSP configuration and plugings
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- automatic install lsp
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            -- shows update status for LSP
            { "j-hui/fidget.nvim", opts = {} },
            -- neodev
            "folke/neodev.nvim",
        },
    },
    -- auto completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- snippet engine
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            -- add lsp completion
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            -- user friendly snippets
            "rafamadriz/friendly-snippets",
        },
    },

    -- go development
    "fatih/vim-go",
    -- zig
    "ziglang/zig.vim",

    -- debugger (DAP)
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    -- -- use 'mfussenegger/nvim-dap-python'
    -- use 'ldelossa/nvim-dap-projects'
    "leoluz/nvim-dap-go", -- Install the plugin with Packer

}, {})

-- plugin configurations
require('plugins.telescope')
require('plugins.treesitter')
-- require('plugins.lsp-zero')
require('plugins.lsp')
require('plugins.dap')
