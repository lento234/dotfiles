return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",  -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
  },
  keys = {
    { "<leader>gg", ":Neogit<CR>", desc = "[g]o launch neo[g]it" },
  },
  config = true,
}
