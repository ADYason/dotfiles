vim.g.mapleader = ' '
vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.syntax = on
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.loader.enable()
vim.g.loadednetrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd('set nobackup')
vim.opt.completeopt="longest"
vim.o.clipboard = "unnamedplus"
vim.opt.fillchars = {eob = " "}  -- removes tildas
