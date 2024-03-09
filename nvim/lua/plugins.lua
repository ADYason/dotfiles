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
  use 'wbthomason/packer.nvim'
  use 'echasnovski/mini.statusline'
  use 'folke/lsp-colors.nvim'
  use {
   'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({with_sync = true})
      ts_update()
    end,
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    }
  }
  use 'Mofiqul/vscode.nvim'
  -- telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }}
  }
  -- vim-startuptime
  use {
    'dstein64/vim-startuptime'
  }
  -- lsp-zero
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      --- Uncomment these if you want to manage LSP servers from neovim
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
    }
  }
  use {'jose-elias-alvarez/null-ls.nvim'}
  use { 'mfussenegger/nvim-dap', requires = {'rcarriga/nvim-dap-ui'}}
  use {
    "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      requires = {
	"nvim-lua/plenary.nvim",
      },
  }
  use {"folke/todo-comments.nvim"}
  use({
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup()
    end,
  })
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end}
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup {}
    end
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
