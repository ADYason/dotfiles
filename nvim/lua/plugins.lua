local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"echasnovski/mini.statusline",
	"folke/lsp-colors.nvim",
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		lazy = false,
	},
	"nvim-treesitter/nvim-treesitter-context",
	"ThePrimeagen/harpoon",
	{
		"kdheepak/tabline.nvim",
		dependencies = { "hoob3rt/lualine.nvim" },
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"Mofiqul/vscode.nvim",
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
	"dstein64/vim-startuptime",
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"SergioRibera/cmp-dotenv",
			"L3MON4D3/LuaSnip",
		},
	},
	"jose-elias-alvarez/null-ls.nvim",
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
	},
	"leoluz/nvim-dap-go",
	{
		"ray-x/go.nvim",
		dependencies = { "ray-x/guihua.lua" },
	},
	"folke/todo-comments.nvim",
	"stevearc/conform.nvim",
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
		},
	},
	"akinsho/toggleterm.nvim",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{ "mg979/vim-visual-multi", branch = "master" },
	{
		"tanvirtin/vgit.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"lukas-reineke/indent-blankline.nvim",
	{
		"anuvyklack/pretty-fold.nvim",
		config = function()
			require("pretty-fold").setup()
		end,
	},
	"LunarVim/bigfile.nvim",
	{
		"amitds1997/remote-nvim.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"ThePrimeagen/refactoring.nvim",
		version = "*",
		dependencies = {
			"lewis6991/async.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"terrastruct/d2-vim",
		ft = { "d2" },
	},
})
