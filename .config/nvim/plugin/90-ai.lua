-- sidekick: runs AI CLIs (Claude Code) in a terminal split and sends editor context to them
require("sidekick").setup({
	-- next edit suggestions need the Copilot language server, which isn't installed
	nes = { enabled = false },
	cli = {
		win = { layout = "right", split = { width = 100 } },
	},
})

local function cli(fn, opts)
	return function()
		require("sidekick.cli")[fn](opts)
	end
end

local map = vim.keymap.set
map({ "n", "t", "i", "x" }, "<C-.>", cli("focus"), { desc = "Sidekick focus" })
map("n", "<leader>aa", cli("toggle", { name = "claude", focus = true }), { desc = "[a]i toggle Claude" })
map("n", "<leader>as", cli("select", { filter = { installed = true } }), { desc = "[a]i [s]elect CLI" })
map("n", "<leader>ad", cli("close"), { desc = "[a]i [d]etach session" })
map({ "n", "x" }, "<leader>at", cli("send", { msg = "{this}" }), { desc = "[a]i send [t]his" })
map("n", "<leader>af", cli("send", { msg = "{file}" }), { desc = "[a]i send [f]ile" })
map("x", "<leader>av", cli("send", { msg = "{selection}" }), { desc = "[a]i send [v]isual selection" })
map({ "n", "x" }, "<leader>ap", cli("prompt"), { desc = "[a]i select [p]rompt" })
