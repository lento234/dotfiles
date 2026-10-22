local gitsigns = require("gitsigns")

gitsigns.setup({
	current_line_blame_formatter = "<abbrev_sha>: <author>, <author_time:%Y-%m-%d> - <summary>",
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	on_attach = function(bufnr)
		local function map(mode, l, r, desc)
			vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
		end

		-- navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, "next git hunk")
		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, "previous git hunk")

		-- visual mode
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "stage git hunk")
		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "reset git hunk")

		-- normal mode
		map("n", "<leader>hs", gitsigns.stage_hunk, "git stage/unstage hunk")
		map("n", "<leader>hr", gitsigns.reset_hunk, "git reset hunk")
		map("n", "<leader>hS", gitsigns.stage_buffer, "git stage buffer")
		map("n", "<leader>hR", gitsigns.reset_buffer, "git reset buffer")
		map("n", "<leader>hp", gitsigns.preview_hunk, "preview git hunk")
		map("n", "<leader>hh", function()
			require("custom.stash_hunk").stash_hunk()
		end, "git stash hunk (append to latest hunk stash)")
		map("n", "<leader>hH", function()
			require("custom.stash_hunk").stash_hunk({ new = true })
		end, "git stash hunk (new stash)")
		map("n", "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end, "git blame line")
		map("n", "<leader>hB", gitsigns.blame, "git blame buffer")
		map("n", "<leader>hd", gitsigns.diffthis, "git diff against index")
		map("n", "<leader>hD", function()
			gitsigns.diffthis("~")
		end, "git diff against last commit")

		-- toggles
		map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "toggle git blame line")
		map("n", "<leader>td", gitsigns.toggle_deleted, "toggle git show deleted")
		map("n", "<leader>tp", gitsigns.preview_hunk_inline, "toggle git preview hunk inline")

		-- text object
		map({ "o", "x" }, "ih", gitsigns.select_hunk, "select git hunk")
	end,
})

-- neogit
require("neogit").setup({ graph_style = "kitty" })
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "[g]o neo[g]it" })

-- diffview
require("diffview").setup({})
vim.keymap.set("n", "<leader>dm", "<cmd>DiffviewOpen main<CR>", { desc = "[d]iffview against [m]ain" })

-- snacks git helpers (snacks is set up in plugin/20-ui.lua)
vim.keymap.set({ "n", "x" }, "<leader>gB", function()
	Snacks.gitbrowse()
end, { desc = "[g]it [B]rowse" })
vim.keymap.set("n", "<leader>gb", function()
	Snacks.git.blame_line()
end, { desc = "[g]it [b]lame line" })
vim.keymap.set("n", "<leader>gll", function()
	Snacks.picker.git_log_line()
end, { desc = "[g]it [l]og for current [l]ine" })
vim.keymap.set("n", "<leader>glg", function()
	Snacks.lazygit.log()
end, { desc = "[g]it [l]og [g]raph (lazygit)" })
vim.keymap.set("n", "<leader>lg", function()
	Snacks.lazygit()
end, { desc = "[l]azy[g]it" })
