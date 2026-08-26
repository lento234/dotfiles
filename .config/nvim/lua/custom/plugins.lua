local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd}):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ''
    local stdout = result.stdout or ''
    local output = stderr ~= '' and stderr or stdout
    if output == '' then output = 'no output from build command' end
    vim.notify(('build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run_build(name, {'make'}, ev.data.path)
      return
    end

    if name == 'LuaSnip' then
      if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
      return
    end

    if name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
      return
    end
  end,
})

local function gh(repo)
  return 'https://github.com/' .. repo
end

-- colorscheme
vim.pack.add { { src = gh 'catppuccin/nvim', name = 'catppuccin' } }
vim.cmd.colorscheme 'catppuccin-mocha'

-- mini.nvim
--  A collection of various small independent plugins/modules
vim.pack.add { gh 'nvim-mini/mini.nvim' }
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  MiniIcons.mock_nvim_web_devicons()
end

-- Better Around/Inside textobjects
require('mini.ai').setup {
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}
-- Add/delete/replace surroundings (brackets, quotes, etc.)
require('mini.surround').setup {}

-- Simple and easy statusline.
local statusline = require 'mini.statusline'
-- Set `use_icons` to true if you have a Nerd Font
statusline.setup { use_icons = vim.g.have_nerd_font }
statusline.section_location = function() return '%2l:%-2v' end

-- formatting
-- indentation
vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}

-- git
vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~'}, 
    delete = { text = '_'},
    topdelete = { text = '‾'},
    changedelete = { text = '~'},
  },
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- actions
    -- visual mode
    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'stage git hunk' })
    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'reset git hunk' })
    -- normal mode
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git stage hunk' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git reset hunk' })
    map('n', '<leader>hs', gitsigns.stage_buffer, { desc = 'git stage buffer' })
    map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'undo stage hunk' })
    map('n', '<leader>hr', gitsigns.reset_buffer, { desc = 'git reset buffer' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'preview git hunk' })
    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end, { desc = 'git blame line' })
    map('n', '<leader>hb', function()
      gitsigns.blame()
    end, { desc = 'git blame buffer' })
    map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git diff against index' })
    map('n', '<leader>hd', function()
      gitsigns.diffthis('~')
    end, { desc = 'git diff against last commit' })

    -- toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'toggle git blame line' })
    map('n', '<leader>td', gitsigns.toggle_deleted, { desc = 'toggle git show deleted' })

    -- text object
    map({ 'o', 'x' }, 'ih', ':<c-u>gitsigns select_hunk<cr>', { desc = 'select git hunk' })
  end,
}

local function noremap(mode, lhs, rhs, desc, opts)
	opts = opts or { silent = true }
	vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true, silent = opts['silent'] })
end

-- neogit
vim.pack.add { gh 'NeogitOrg/neogit' }
noremap('n', '<leader>gg', '<cmd>Neogit<cr>', '[g]o neo[g]it')

-- which-key
vim.pack.add { gh 'folke/which-key.nvim' }
require('which-key').setup {
  delay = 300,
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { '<leader>s', group = '[s]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[t]oggle' },
    { '<leader>h', group = 'git [h]unk', mode = { 'n', 'v' } }, 
    { 'gr', group = 'LSP actions', mode = { 'n' } },
  },
}
