-- stash the git hunk under the cursor, appending to a running "nvim-hunks" stash
local M = {}

local MARKER = "nvim-hunks"
local CONTEXT = 3

local function git(args, opts)
	opts = opts or {}
	local cmd = vim.list_extend({ "git" }, args)
	local res = vim.system(cmd, { cwd = opts.cwd, env = opts.env, stdin = opts.stdin, text = true }):wait()
	if res.code ~= 0 then
		error(vim.trim(res.stderr ~= "" and res.stderr or res.stdout), 0)
	end
	return res.stdout
end

local function hunk_at(hunks, lnum)
	for _, h in ipairs(hunks) do
		local first = math.max(h.added.start, 1)
		local last = first + math.max(h.added.count, 1) - 1
		if lnum >= first and lnum <= last then
			return h
		end
	end
end

-- gitsigns hunks have no context, so add some from the index to let `git apply` relocate them
local function build_patch(relpath, index_lines, hunk)
	local removed, added = hunk.removed, hunk.added
	local old_first = removed.count == 0 and removed.start + 1 or removed.start
	local new_first = added.count == 0 and added.start + 1 or added.start
	local pre_start = math.max(1, old_first - CONTEXT)
	local pre = vim.list_slice(index_lines, pre_start, old_first - 1)
	local post = vim.list_slice(index_lines, old_first + removed.count, old_first + removed.count + CONTEXT - 1)
	local old_count = #pre + removed.count + #post
	local new_count = #pre + added.count + #post

	local lines = {
		("diff --git a/%s b/%s"):format(relpath, relpath),
		"--- a/" .. relpath,
		"+++ b/" .. relpath,
		("@@ -%d,%d +%d,%d @@"):format(
			old_count == 0 and 0 or pre_start,
			old_count,
			new_count == 0 and 0 or new_first - #pre,
			new_count
		),
	}
	for _, l in ipairs(pre) do
		lines[#lines + 1] = " " .. l
	end
	vim.list_extend(lines, hunk.lines)
	for _, l in ipairs(post) do
		lines[#lines + 1] = " " .. l
	end
	return table.concat(lines, "\n") .. "\n"
end

local is_hunk_stash, store

--- @param opts? { new?: boolean } start a fresh stash instead of appending to the latest one
function M.stash_hunk(opts)
	opts = opts or {}
	local bufnr = vim.api.nvim_get_current_buf()
	if vim.bo[bufnr].modified then
		vim.notify("save the buffer before stashing a hunk", vim.log.levels.WARN)
		return
	end
	local hunk = hunk_at(require("gitsigns").get_hunks(bufnr) or {}, vim.fn.line("."))
	if not hunk then
		vim.notify("no hunk under cursor", vim.log.levels.WARN)
		return
	end

	local ok, ctx = pcall(function()
		local path = vim.api.nvim_buf_get_name(bufnr)
		local root = vim.trim(git({ "rev-parse", "--show-toplevel" }, { cwd = vim.fs.dirname(path) }))
		local relpath = vim.fs.relpath(root, path)
		local index_lines = vim.split(git({ "show", ":" .. relpath }, { cwd = root }), "\n", { plain = true })
		if index_lines[#index_lines] == "" then
			table.remove(index_lines)
		end
		local top = vim.trim(git({ "stash", "list", "-1", "--format=%gs" }, { cwd = root }))
		return {
			root = root,
			patch = build_patch(relpath, index_lines, hunk),
			top = top,
			append = not opts.new and is_hunk_stash(top),
			branch = vim.trim(git({ "rev-parse", "--abbrev-ref", "HEAD" }, { cwd = root })),
		}
	end)
	if not ok then
		vim.notify("stash hunk failed: " .. ctx, vim.log.levels.ERROR)
		return
	end

	if ctx.append then
		return store(bufnr, ctx, ctx.top)
	end
	vim.ui.input({ prompt = "Stash name: " }, function(name)
		if name == nil then
			return
		end
		name = vim.trim(name)
		store(bufnr, ctx, ("On %s: %s"):format(ctx.branch, name == "" and MARKER or MARKER .. ": " .. name))
	end)
end

-- a stash we created: "On <branch>: nvim-hunks" or "On <branch>: nvim-hunks: <name>"
function is_hunk_stash(top)
	local subject = top:match("^On [^:]+: (.*)$")
	return subject ~= nil and (subject == MARKER or vim.startswith(subject, MARKER .. ": "))
end

function store(bufnr, ctx, msg)
	local root, patch, append = ctx.root, ctx.patch, ctx.append
	local ok, result = pcall(function()
		local head, index_commit, base_tree
		if append then
			head = vim.trim(git({ "rev-parse", "stash@{0}^1" }, { cwd = root }))
			index_commit = vim.trim(git({ "rev-parse", "stash@{0}^2" }, { cwd = root }))
			base_tree = "stash@{0}^{tree}"
		else
			head = vim.trim(git({ "rev-parse", "HEAD" }, { cwd = root }))
			base_tree = "HEAD^{tree}"
			index_commit =
				vim.trim(git({ "commit-tree", base_tree, "-p", head, "-m", "index on " .. MARKER }, { cwd = root }))
		end

		-- build the new stash tree in a throwaway index so the real index is untouched
		local tmp_index = vim.fn.tempname()
		local env = { GIT_INDEX_FILE = tmp_index }
		local tree_ok, tree = pcall(function()
			git({ "read-tree", base_tree }, { cwd = root, env = env })
			git({ "apply", "--cached", "-" }, { cwd = root, env = env, stdin = patch })
			return vim.trim(git({ "write-tree" }, { cwd = root, env = env }))
		end)
		os.remove(tmp_index)
		if not tree_ok then
			error(tree, 0)
		end
		local stash = vim.trim(git({ "commit-tree", tree, "-p", head, "-p", index_commit, "-m", msg }, { cwd = root }))

		git({ "apply", "-R", "-" }, { cwd = root, stdin = patch })
		git({ "stash", "store", "-m", msg, stash }, { cwd = root })
		if append then
			git({ "stash", "drop", "-q", "stash@{1}" }, { cwd = root })
		end
	end)

	if not ok then
		vim.notify("stash hunk failed: " .. result, vim.log.levels.ERROR)
		return
	end
	-- reload from disk without moving the cursor or scroll position
	vim.api.nvim_buf_call(bufnr, function()
		local view = vim.fn.winsaveview()
		vim.cmd("silent edit")
		vim.fn.winrestview(view)
	end)
	vim.notify(("hunk %s stash@{0} (%s)"):format(append and "appended to" or "stashed in new", msg))
end

return M
