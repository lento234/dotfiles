local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  -- package manager
  use 'wbthomason/packer.nvim'

  -- colorscheme
  use 'ellisonleao/gruvbox.nvim'
  -- use 'bluz71/vim-moonfly-colors'
  -- use 'EdenEast/nightfox.nvim'
  -- use 'arcticicestudio/nord-vim'
  -- use 'navarasu/onedark.nvim'
  -- use 'rmehri01/onenord.nvim'

  -- icons
  use 'nvim-tree/nvim-web-devicons'

  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true}
  }

  -- blankline
  use "lukas-reineke/indent-blankline.nvim"

  -- A bar that will show at the top of you nvim containing your open buffers.
  use {'romgrk/barbar.nvim', requires = 'nvim-web-devicons'}
  -- use 'nanozuki/tabby.nvim'

  -- file explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons'}
  }

  -- Git plugins
  use 'lewis6991/gitsigns.nvim' -- git signs
  -- use 'tpope/vim-fugitive' -- Git commands for nvim.

  -- commenting (gcc, gcap)
  use 'tpope/vim-commentary'

  -- telescope for file, search, ...
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  } -- UI to select things (files, search results, open buffers...)


  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  }

  -- Highlight, edit, and navigate code using a fast incremental parsing library.
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  -- auto closing
  use 'windwp/nvim-autopairs'

  -- Replace text (go replace word: grw)
  use 'vim-scripts/ReplaceWithRegister'

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      -- {'hrsh7th/cmp-buffer'},       -- Optional
      -- {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      -- {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  }


  -- Useful status update for LSP
  use {
    'j-hui/fidget.nvim',
    branch = 'legacy'
  }

  use 'folke/neodev.nvim'

  -- -- alpha: greeter for neovim
  use {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  }

  -- which-key
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- -- debugger (DAP)
  -- use 'mfussenegger/nvim-dap'
  -- use 'rcarriga/nvim-dap-ui'
  -- use 'theHamsta/nvim-dap-virtual-text'
  -- -- use 'mfussenegger/nvim-dap-python'
  -- use 'ldelossa/nvim-dap-projects'

  -- -- terminal
  -- use {"akinsho/toggleterm.nvim", tag = '*', config = function()
  --   require("toggleterm").setup()
  -- end}

  -- use 'NoahTheDuke/vim-just'

  -- tabstop and shiftwidth automatically
  use 'tpope/vim-sleuth'

  -- surround
  use 'tpope/vim-surround'

  -- Git diff view
  -- use "sindrets/diffview.nvim"

  -- whitespace
  use 'ntpeters/vim-better-whitespace'

  -- go development
  use 'fatih/vim-go'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

