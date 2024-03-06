require('neosolarized').setup({
  background_set = false,
})
require("lsp-colors").setup({
    Error = "#db4b4b",
    Warning = "#e0af68",
    Information = "#0db9d7",
    Hint = "#10B981"
  })
require('mini.statusline').setup()
require('nvim-tree').setup()
require'telescope-config'
require'todo-comments'.setup()
