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

return require('packer').startup(function(use)
  -- package manager
  use 'wbthomason/packer.nvim'
  
  -- colorscheme
  -- use 'ellisonleao/gruvbox.nvim'
  -- use 'bluz71/vim-moonfly-colors'
  use 'navarasu/onedark.nvim'
  -- use 'EdenEast/nightfox.nvim'

  -- file explorer
  use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons'} }
  
  -- status line
  use 'nvim-lualine/lualine.nvim'

  -- Git plugins
  use 'lewis6991/gitsigns.nvim' -- git signs
  use 'tpope/vim-fugitive' -- Git commands for nvim.

  -- commenting (gcc, gcap)
  use 'tpope/vim-commentary'

  -- telescope for file, search, ...
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- UI to select things (files, search results, open buffers...)

  use 'nvim-treesitter/nvim-treesitter' -- Highlight, edit, and navigate code using a fast incremental parsing library.

  -- A bar that will show at the top of you nvim containing your open buffers.
  use { 'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'} }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
