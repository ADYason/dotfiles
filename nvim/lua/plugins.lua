local Plug = vim.fn['plug#']
vim.call("plug#begin")
Plug 'echasnovski/mini.statusline'  -- lower bar
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter' -- treesitter
Plug 'folke/lsp-colors.nvim' -- lsp highlitin
Plug ('catppuccin/nvim', { as = 'catppuccin' })

Plug "RRethy/nvim-base16"
Plug 'tjdevries/colorbuddy.nvim'
Plug "svrana/neosolarized.nvim"

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug ('L3MON4D3/LuaSnip', {tag='v2.*', ['do'] = 'make install_jsregexp'})
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'ray-x/lsp_signature.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'nvim-treesitter/playground'
Plug ('VonHeikemen/lsp-zero.nvim', {branch = 'v3.x'})
Plug ('numirias/semshi' , {['do'] = ':UpdateRemotePlugins'})

Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
vim.call('plug#end')
require("lsp-colors").setup({
    Error = "#db4b4b",
    Warning = "#e0af68",
    Information = "#0db9d7",
    Hint = "#10B981"
  })
require('mini.statusline').setup()
require('neosolarized').setup({
  background_set = false,
})
require('nvim-tree').setup()
