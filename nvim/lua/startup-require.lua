require("lsp-colors").setup({
	Error = "#db4b4b",
	Warning = "#e0af68",
	Information = "#0db9d7",
	Hint = "#10B981",
})
require("mini.statusline").setup()
require("telescope-config")
require("todo-comments").setup()
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_fix", "ruff_format" },
		javascript = { "prettierd", "prettier" },
		go = { "goimports", "gofmt" },
		json = { "fixjson" },
	},
})
vim.o.background = "dark"
vim.g.loaded_python3_provider = 0 -- i hate python
local c = require("vscode.colors").get_colors()
require("vscode").setup({
	transparent = true,
	italic_comments = false,
	disable_nvimtree_bg = true,
	underline_links = true,
	color_overrides = {
		vscLineNumber = "#FFFFFF",
	},
	group_overrides = {
		Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
	},
})
require("vscode").load()
require("nvim-tree").setup()
require("toggleterm").setup({})
require("gitblame").setup({
	enabled = false,
	message_when_not_committed = "	Закоммить, собака!",
})
require("vgit").setup({ settings = { live_blame = { enabled = false }, authorship_code_lens = { enabled = false } } })

local highlight = {
	"Green",
}
-- disable indentation on the first level
local hooks = require("ibl.hooks")
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "Green", { fg = "#00FF00" })
end)
require("ibl").setup({
	indent = {
		char = "│",
		highlight = highlight,
	},
	scope = {
		enabled = false,
	},
})
require("bigfile").setup({
	filesize = 1,
	pattern = { "*" },
	features = {
		"indent_blankline",
		"illuminate",
		"lsp",
		"treesitter",
		"syntax",
		"matchparen",
		"vimopts",
		"filetype",
	},
})
require("remote-nvim").setup()
