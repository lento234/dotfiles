return {
  "romgrk/barbar.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("barbar").setup({})
    local function noremap(mode, lhs, rhs, desc, opts)
      opts = opts or { silent = true }
      vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true, silent = opts["silent"] })
    end

    -- Move to previous/next
    noremap("n", "<C-q>", ":BufferClose<CR>", "buffer close")
    noremap("n", "<A-h>", "<Cmd>BufferPrevious<CR>", "buffer prev")
    noremap("n", "<A-l>", "<Cmd>BufferNext<CR>", "buffer next")
    noremap("n", "<A-H>", "<Cmd>BufferMovePrevious<CR>", "buffer move to prev")
    noremap("n", "<A-L>", "<Cmd>BufferMoveNext<CR>", "buffer move to next")

    -- Magic buffer-picking mode
    noremap("n", "<C-p>", "<Cmd>BufferPick<CR>", "buffer [p]ick")
    noremap("n", "<A-p>", "<Cmd>BufferPin<CR>", "buffer pin")
  end,
}
