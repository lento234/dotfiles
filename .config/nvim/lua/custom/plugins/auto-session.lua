return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    { "<leader>ss", ":AutoSession save<CR>",    desc = "[s]session: [s]ave" },
    { "<leader>sd", ":AutoSession delete<CR>",  desc = "[s]session: [d]elete" },
    { "<leader>sr", ":AutoSession restore<CR>", desc = "[s]session: [r]estore" },
  },
  config = function()
    require("auto-session").setup({
      -- pre_save_cmds = { "NeoTree close" },
      pre_save_cmds = { "tabdo NvimTreeClose" },
      log_level = "error",
      suppressed_dirs = { '~/', '~/Downloads', '/' },
    })
  end,
}
