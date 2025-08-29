return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-vim-test",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
  keys = {
    { "<leader>tr", "<cmd>Neotest run<cr>",                                      desc = "[t]est: [r]un" },
    { "<leader>ti", "<cmd>Neotest output<cr>",                                   desc = "[t]est: [i]inspect" },
    { "<leader>ts", "<cmd>Neotest summary<cr>",                                  desc = "[t]est: [s]ummary" },
    { "<leader>ta", "<cmd>lua require('neotest').run.run({ suite = true })<cr>", desc = "[t]est: [a]ll" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
        }),
        require("neotest-plenary"),
        require("neotest-vim-test")({
          ignore_file_types = { "python", "vim", "lua" },
        }),
      },
    })
  end
}
