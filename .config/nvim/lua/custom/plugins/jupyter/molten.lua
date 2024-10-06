return {
    "benlubas/molten-nvim",
    version = "^1.0.0",                              -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    ft = { "python", "norg", "markdown", "quarto" }, -- this is just to avoid loading image.nvim, loading molten at the start has minimal startup time impact
    dev = true,
    build = ":UpdateRemotePlugins",
    init = function()
        -- vim.g.molten_open_cmd = "firefox"
        -- these are examples, not defaults. Please see the readme
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 20
        vim.g.molten_auto_open_output = false
        vim.g.molten_wrap_output = true
        vim.g.molten_virt_text_output = true
        vim.g.molten_virt_lines_off_by_1 = true
        local function noremap(mode, lhs, rhs, desc, opts)
            opts = opts or { silent = true }
            vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true, silent = opts["silent"] })
        end
        noremap("n", "<leader>mi", ":MoltenInit<CR>", "[m]olten [i]init")
        noremap("v", "<A-CR>", ":<C-u>MoltenEvaluateVisual<CR>", "[m]olten: eval visual")
        noremap("n", "<A-CR>", ":MoltenReevaluateCell<CR>", "[m]olten: [r]e-eval cell")
        noremap("n", "<leader>mb", ":MoltenOpenInBrowser<CR>", "[m]olten: [b]rowser")

        vim.api.nvim_create_autocmd("User", {
            pattern = "MoltenInitPost",
            callback = function()
                -- quarto code runner mappings
                local r = require("quarto.runner")
                vim.keymap.set("n", "<localleader>rc", r.run_cell, { desc = "run cell", silent = true })
                vim.keymap.set("n", "<localleader>ra", r.run_above, { desc = "run cell and above", silent = true })
                vim.keymap.set("n", "<localleader>rb", r.run_below, { desc = "run cell and below", silent = true })
                vim.keymap.set("n", "<localleader>rl", r.run_line, { desc = "run line", silent = true })
                vim.keymap.set("n", "<localleader>rA", r.run_all, { desc = "run all cells", silent = true })
                vim.keymap.set("n", "<localleader>RA", function()
                    r.run_all(true)
                end, { desc = "run all cells of all languages", silent = true })

                -- setup some molten specific keybindings
                vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>",
                    { desc = "evaluate operator", silent = true })
                vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>",
                    { desc = "re-eval cell", silent = true })
                vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
                    { desc = "execute visual selection", silent = true })
                vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>",
                    { desc = "open output window", silent = true })
                vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>",
                    { desc = "close output window", silent = true })
                vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>",
                    { desc = "delete Molten cell", silent = true })
                local open = false
                vim.keymap.set("n", "<localleader>ot", function()
                    open = not open
                    vim.fn.MoltenUpdateOption("auto_open_output", open)
                end)
                -- if we're in a python file, change the configuration a little
                if vim.bo.filetype == "python" then
                    vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false)
                    vim.fn.MoltenUpdateOption("molten_virt_text_output", false)
                end
            end,
        })
        -- -- change the configuration when editing a python file
        -- vim.api.nvim_create_autocmd("BufEnter", {
        --     pattern = "*.py",
        --     callback = function(e)
        --         if string.match(e.file, ".otter.") then
        --             return
        --         end
        --         if require("molten.status").initialized() == "Molten" then
        --             vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false)
        --             vim.fn.MoltenUpdateOption("molten_virt_text_output", false)
        --         end
        --     end,
        -- })
        --
        -- -- Undo those config changes when we go back to a markdown or quarto file
        -- vim.api.nvim_create_autocmd("BufEnter", {
        --     pattern = { "*.qmd", "*.md", "*.ipynb" },
        --     callback = function()
        --         if require("molten.status").initialized() == "Molten" then
        --             vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", true)
        --             vim.fn.MoltenUpdateOption("molten_virt_text_output", true)
        --         end
        --     end,
        -- })
    end,
}
