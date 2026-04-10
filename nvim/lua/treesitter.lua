require('nvim-treesitter').install({
  'lua', 'rust', 'python', 'yaml', 'javascript', 'typescript', 'markdown', 'markdown_inline',
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
