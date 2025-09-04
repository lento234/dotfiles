return {
  -- git plugins
  "tpope/vim-fugitive",
  -- Git diff view
  {
    "sindrets/diffview.nvim",
    keys = {
      {
        "<leader>dvm", "<cmd>DiffviewOpen main<cr>", desc = "[d]iff[v]iew open [m]ain"
      },
    },
  }
}
