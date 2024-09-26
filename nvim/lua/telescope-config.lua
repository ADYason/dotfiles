local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
require("telescope").setup({
	pickers = {
		find_files = {
			hidden = false,
		},
	},
	defaults = {
		mappings = {
			i = {
				["<c-d>"] = actions.delete_buffer + actions.move_to_top,
			},
			n = {
				["<c-d>"] = actions.delete_buffer + actions.move_to_top,
				["O"] = actions.select_tab,
				["o"] = actions.select_default,
			},
		},
	},
})
require("telescope").load_extension("fzf")
