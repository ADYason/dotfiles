require("lsp-colors").setup({
    Error = "#db4b4b",
    Warning = "#e0af68",
    Information = "#0db9d7",
    Hint = "#10B981"
  })
require('mini.statusline').setup()
require'telescope-config'
require'todo-comments'.setup()
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "ruff_fix", "ruff_format" },
    -- Use a sub-list to run only the first available formatter
    javascript = { { "prettierd", "prettier" } },
  },
})
vim.o.background = 'dark'
local c = require('vscode.colors').get_colors()
require('vscode').setup({
    transparent = false,
    italic_comments = true,
    disable_nvimtree_bg = false,
    underline_links = true,
    color_overrides = {
        vscLineNumber = '#FFFFFF',
    },
    group_overrides = {
        Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
    }
})
require('vscode').load()
require('nvim-tree').setup()
require'toggleterm'.setup{}
