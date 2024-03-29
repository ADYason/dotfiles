local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", "<cmd>:NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>new", ":e tmp.")
vim.keymap.set("i", "<C-Del>", "<C-W>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

vim.keymap.set("n", "<C-`>", ":ToggleTerm<CR>")
