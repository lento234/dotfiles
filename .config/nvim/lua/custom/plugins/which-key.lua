return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    spec = {
      { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      { "<leader>f", group = "[F]ind" },
      { "<leader>d", group = "[D]ap" },
      { "<leader>x", group = "Trouble" },
      { "<leader>t", group = "Toggle" },
      { "<leader>o", group = "Obsidian" },
      { "<leader>r", group = "Overseer" },
    },
  },
}
