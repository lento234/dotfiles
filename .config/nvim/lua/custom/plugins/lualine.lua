return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		-- "ThePrimeagen/harpoon",
		"rmagatti/auto-session",
	},
	config = function()
		-- add hapoon tag
		-- local harpoon = require("harpoon")
		-- harpoon:setup()

		-- local function get_current_mark()
		-- 	local current_filename = vim.fn.expand("%:p")
		-- 	for i, item in ipairs(harpoon:list().items) do
		-- 		local fpath = vim.fn.fnamemodify(item.value, ":p")
		-- 		if current_filename == fpath then
		-- 			return i
		-- 		end
		-- 	end
		-- 	return nil
		-- end

		-- local function harpoon_component()
		-- 	local total_marks = harpoon:list():length()
		-- 	if total_marks == 0 then
		-- 		return ""
		-- 	end
		-- 	local current_mark = ""
		-- 	local mark_idx = get_current_mark()
		-- 	if mark_idx ~= nil then
		-- 		current_mark = tostring(mark_idx)
		-- 	end
		-- 	return string.format("󱡅 %s/%d", current_mark, total_marks)
		-- end
		require("lualine").setup({
			sections = {
				-- lualine_b = { harpoon_component, "branch", "diff", "diagnostics" },
				lualine_c = { require("auto-session.lib").current_session_name, "filename" },
			},
		})
	end,
}
