return {
  -- file explorer
  "nvim-tree/nvim-tree.lua",
  lazy = true,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { "<leader>n", ":NvimTreeFindFileToggle<CR>", desc = "tree: show file in [n]vim-tree", silent = true },
    -- { "<leader>tn", ":NvimTreeToggle<CR>", desc = "tree: [t]oggle [n]vim-tree"}
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("nvim-tree").setup({
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              -- arrow_closed = "",
              -- arrow_open = "",
            },
          },
        },
      },
    })
  end,
}
