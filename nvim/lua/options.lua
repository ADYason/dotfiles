vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.syntax = "on"
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.loader.enable()
vim.g.loadednetrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("set nobackup")
vim.opt.completeopt = "longest"
vim.o.clipboard = "unnamedplus"
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.opt.fillchars = { eob = " " } -- removes tildas
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
