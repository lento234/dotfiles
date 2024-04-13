return {
  "akinsho/toggleterm.nvim",
  lazy = true,
  version = '*',
  keys = {
    { "<leader>tt", ":ToggleTerm direction=float<CR>", desc = "terminal: [t]oggle [t]erminal" },
    { "<esc>",      [[<C-\><C-n>]],                    mode = "t",                            desc = "terminal: escape to normal mode" },
  },
  opts = {},
}
