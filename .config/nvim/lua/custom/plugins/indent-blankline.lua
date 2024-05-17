return {
  "lukas-reineke/indent-blankline.nvim",
  version = "3.5", -- FIXME: pinned to nvim 0.9.x
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    scope = { enabled = false },
  },
}
