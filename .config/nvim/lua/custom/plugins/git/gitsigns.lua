return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		current_line_blame_formatter = "<abbrev_sha>: <author>, <author_time:%Y-%m-%d> - <summary>",
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end)

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end)

			-- Actions
			-- visual mode
			map("v", "<leader>hs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "stage git hunk" })
			map("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "reset git hunk" })
			-- normal mode
			map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git stage hunk" })
			map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git reset hunk" })
			map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git Stage buffer" })
			map("n", "<leader>hu", gitsigns.stage_hunk, { desc = "undo stage hunk" })
			map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git Reset buffer" })
			map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "preview git hunk" })
			map("n", "<leader>hb", function()
				gitsigns.blame_line({ full = true })
			end, { desc = "git blame line" })
			map("n", "<leader>hB", function()
				gitsigns.blame()
			end, { desc = "git blame buffer" })
			map("n", "<leader>hd", gitsigns.diffthis, { desc = "git diff against index" })
			map("n", "<leader>hD", function()
				gitsigns.diffthis("~")
			end, { desc = "git diff against last commit" })

			-- Toggles
			map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "toggle git blame line" })
			map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "toggle git show deleted" })

			-- Text object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
		end,
	},
}
