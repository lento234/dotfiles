local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
  return
end

treesitter.setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  ensure_installed = {
    'bash',
    'c',
    'cpp',
    'dockerfile',
    'go',
    -- 'help',
    'lua',
    'markdown',
    'python',
    'rust',
    'vim',
    'yaml',
  },
  auto_install = true,

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {
      [']m'] = '@function.outer',
      [']]'] = '@class.outer',
    },
    goto_next_end = {
      [']M'] = '@function.outer',
      [']['] = '@class.outer',
    },
    goto_previous_start = {
      ['[m'] = '@function.outer',
      ['[['] = '@class.outer',
    },
    goto_previous_end = {
      ['[M'] = '@function.outer',
      ['[]'] = '@class.outer',
    },
  },
})
