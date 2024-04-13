return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon").setup({
      settings = {
        -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
        save_on_toggle = true,
      }
    })
    local function noremap(mode, lhs, rhs, desc, opts)
      opts = opts or { silent = true }
      vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true, silent = opts["silent"] })
    end

    -- plugin: harpoon
    local harpoon = require("harpoon")

    noremap("n", "<leader>a", function() harpoon:list():append() end, "harpoon: [a]ppend file")
    noremap("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      "harpoon: open [e]xplore menulist")

    for i = 1, 9 do
      noremap("n", "<A-" .. i .. ">", function() harpoon:list():select(i) end, "harpoon: select item [" .. i .. "]")
    end
  end,
}
