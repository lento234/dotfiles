return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
        -- use 'ldelossa/nvim-dap-projects'
        -- custom json parser (for .vscode/launch.json)
        {
            "Joakker/lua-json5",
            build = "./install.sh",
        },
        {
            "Weissle/persistent-breakpoints.nvim",
            opts = {
                load_breakpoints_event = { "BufReadPost" }
            },
        },
        "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
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

        local function noremap(mode, lhs, rhs, desc, opts)
            opts = opts or { silent = true }
            vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true, silent = opts["silent"] })
        end

        -- plugin: dap
        noremap("n", "<F5>",
            function()
                require("dap.ext.vscode").load_launchjs(nil, {})
                require("dap").continue()
            end, "dap: continue (or start + load launch json)")
        noremap("n", "<F10>", function() require("dap").step_over() end, "dap: step over")
        noremap("n", "<F11>", function() require("dap").step_into() end, "dap: step into")
        noremap("n", "<F12>", function() require("dap").step_out() end, "dap: step out")
        -- save breakpoints to file automatically.
        noremap("n", "<leader>b", function() require("persistent-breakpoints.api").toggle_breakpoint() end,
            "dap: toggle [b]reakpoint")
        noremap("n", "<leader>B", function() require("persistent-breakpoints.api").set_conditional_breakpoint() end,
            "dap: set conditional [B]reakpoint")
        noremap("n", "<leader>dcb", function() require("persistent-breakpoints.api").clear_all_breakpoints() end,
            "[d]ap: [c]lear all [b]reakpoints")

        noremap("n", "<leader>do", function() require("dapui").open() end, "[d]ap: [o]pen")
        noremap("n", "<leader>dC", function() require("dapui").close() end, "[d]ap: [C]lose")
        noremap("n", "<leader>dr", function() require("dap").restart() end, "[d]ap: [r]estart session")
        noremap("n", "<leader>dx", function() require("dap").terminate() end, "[d]ap: e[x]it session")
        noremap("n", "<leader>dl", function() require("dap.ext.vscode").load_launchjs(nil, {}) end,
            "[d]ap: start debug using vscode [l]aunch.json")
        noremap("n", "<leader>df", ":Telescope dap frames<CR>", "[d]ap: telescope list [f]rames")
        noremap("n", "<leader>db", ":Telescope dap list_breakpoints<CR>", "[d]ap: telescope list [b]reakpoints")
        -- dapui
        noremap("n", "<M-k>", function() require("dapui").eval() end, "dap: [k]eval")

        -- require('nvim-dap-projects').search_project_config()
        -- require('dap.ext.vscode').load_launchjs(nil, {})
    end,
}
