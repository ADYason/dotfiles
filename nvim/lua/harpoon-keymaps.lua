local opts = { noremap = true, silent = true }
local map = vim.keymap.set

local h = require("harpoon")
local ht = require("harpoon.term")
local h_ui = require("harpoon.ui")
local hm = require("harpoon.mark")
local htl = require("harpoon.tabline")
local t = require("tabline")

local function nav_next()
	local current_index = hm.get_current_index()
	local number_of_items = hm.get_length()

	if current_index == nil then
		current_index = number_of_items
	else
		current_index = current_index + 1
	end

	if current_index > number_of_items then
		current_index = 1
	end

	while not hm.valid_index(current_index) do
		if current_index > number_of_items then
			return
		end
		current_index = current_index + 1
	end
	h_ui.nav_file(current_index)
end

local function nav_prev()
	local current_index = hm.get_current_index()
	local number_of_items = hm.get_length()

	if current_index == nil then
		current_index = number_of_items
	else
		current_index = current_index - 1
	end

	if current_index < 1 then
		current_index = number_of_items
	end

	while not hm.valid_index(current_index) do
		if current_index < 1 then
			return
		end
		current_index = current_index - 1
	end
	h_ui.nav_file(current_index)
end

local harpoon_settings = {
	save_on_toggle = false,
	save_on_change = true,
	enter_on_sendcmd = false,
	tmux_autoclose_windows = false,
	excluded_filetypes = { "harpoon" },
	mark_branch = false,
}
h.setup(harpoon_settings)

local tabline = "harpoon"
map("n", "<F3>", function()
	if tabline == "harpoon" then
		t.setup({
			show_index = false, -- show tab index
			show_modify = true, -- show buffer modification indicator
			show_icon = true, -- show file extension icon
			fnamemodify = ":t", -- file name modifier
			modify_indicator = "*", -- modify indicator
			no_name = "noname", -- no name buffer name
			brackets = { "", "" }, -- file name brackets surrounding
			inactive_tab_max_length = 0, -- max length of inactive tab titles, 0 to ignore
		})
		map("n", "H", "<cmd>:tabp<CR>")
		map("n", "L", "<cmd>:tabn<CR>")
		tabline = "orig"
	elseif tabline == "orig" then
		htl.setup({})
		map("n", "H", nav_prev, opts)
		map("n", "L", nav_next, opts)
		tabline = "harpoon"
	end
end, opts)

-- files ui

map("n", "<leader>m", h_ui.toggle_quick_menu, opts)
map("n", "<leader>a", hm.add_file, opts)
map("n", "<leader>o", hm.rm_file, opts)
for i = 0, 9, 1 do -- mapping leader + digit to go for files
	map("n", "<leader>" .. i, function()
		h_ui.nav_file(i)
	end, opts)
	map("t", "<leader>" .. i, function()
		h_ui.nav_file(i)
	end, opts)
end

-- terminals
map("n", "<leader>`", function()
	ht.gotoTerminal({
		idx = 1,
		create_with = ":ToggleTerm<CR> direction=tab",
	})
end, opts)
map("t", "<leader>`", function()
	ht.gotoTerminal({
		idx = 1,
		create_with = ":ToggleTerm<CR> direction=tab",
	})
end, opts)
for i = 0, 9, 1 do -- mapping leader + digit to go for terminals
	map("n", "<leader>t" .. i, function()
		ht.gotoTerminal({
			idx = i,
			create_with = ":ToggleTerm<CR> direction=tab",
		})
	end, opts)
	map("t", "<leader>t" .. i, function()
		ht.gotoTerminal({
			idx = i,
			create_with = ":ToggleTerm<CR> direction=tab",
		})
	end, opts)
end
