vim.cmd('syn case match')
vim.cmd[[syn keyword arDeclSpec union enum struct type new module contract ]]
vim.cmd('hi def link arDeclSpec Keyword')

vim.cmd('syn region arComment start="\\\\\\\\" end="$"')
vim.cmd('hi def link arComment Comment')

vim.cmd('syn region arString start=/"/ skip=/\\\\"/ end=/\"/ contains=arEscape')
vim.cmd('hi def link arString String')

vim.cmd[[syn match arEscape display contained /\v\\[bfnrtv'"]|\\x\x{2}|\\\o{1,3}/]]
vim.cmd('hi def link arEscape Special')
vim.cmd[[syn match arFloat  "\v<[ds]_-?\d+.\d*([eE][+-]?\d*)?"]]
vim.cmd[[syn match arNumber "\v<\d+"]]
vim.cmd('hi def link arFloat Number')
vim.cmd('hi def link arNumber Number')

vim.cmd[[syn match arMacro  "\v\@([a-z_A-Z0-9]*)"]]
vim.cmd[[syn match arFieldModifier  "\v\$([a-z_A-Z0-9]*)"]]
vim.cmd[[syn match arTypeSpecifier  "\v#([a-z_A-Z0-9 ]*)" contains=arTypeArg]]
vim.cmd[[syn match arTypeArg display contained /\v ([a-z_A-Z]*)/]]

vim.cmd[[hi arTypeArg guifg=#00ffff]]
vim.cmd[[hi arTypeSpecifier guifg=#298699]]
vim.cmd[[hi arFieldModifier guifg=#5b66d9]]
vim.cmd[[hi arMacro guifg=#db64ff]]
vim.cmd[[hi arLexerMacro guifg=green]]

vim.cmd('hi def link arBuiltinType Type')
vim.cmd[[syn keyword arBuiltinType str int bool null ]]
