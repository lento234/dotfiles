return {
  "folke/trouble.nvim",
  lazy = true,
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  keys = {
    { "<leader>xx", function() require("trouble").toggle() end,                        desc = "[x]trouble: [x]toggle" },
    { "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, desc = "[x]trouble: [w]orkspace" },
    { "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,  desc = "[x]trouble: [d]iagnostics" },
    { "<leader>xq", function() require("trouble").toggle("quickfix") end,              desc = "[x]trouble: [q]uickfix" },
    { "<leader>xl", function() require("trouble").toggle("loclist") end,               desc = "[x]trouble: [l]oclist" },
    { "<leader>xt", "<cmd>TodoTrouble<CR>",                                            desc = "[x]trouble: [t]odos" },
  },
}
