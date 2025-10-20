local dap = require("dap")
local opts = { noremap = true, silent = true }
local map = vim.keymap.set
local util = require("lspconfig/util")
local path = util.path

map("n", "B", dap.toggle_breakpoint, opts) -- set/remove breakpoint
map("n", "<F5>", dap.continue, opts)
map("n", "<leader>x", dap.terminate, opts)
map("n", "F", dap.step_over, opts)
map("n", "<leader>F", dap.step_into, opts) -- step into (a function)
map("n", "<leader>u", dap.step_out, opts) -- step out (of a function)
map("n", "<leader>B", dap.set_exception_breakpoints, opts)

local getVenv = function()
	if vim.env.VIRTUAL_ENV then
		return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end

	local match = vim.fn.glob(path.join(vim.fn.getcwd(), "uv.lock"))
	if match ~= "" then
		local venv = ".venv"
		return path.join(venv, "bin", "python")
	end

	match = vim.fn.glob(path.join(vim.fn.getcwd(), "poetry.lock"))
	if match ~= "" then
		local venv = vim.fn.trim(vim.fn.system("poetry env info -p 2> /dev/null"))
		return path.join(venv, "bin", "python")
	end

	return vim.fn.exepath("python") or vim.fn.exepath("python3") or "python"
end

dap.repl.omnifunc = vim.lsp.omnifunc

dap.adapters.python = function(cb, config)
	if config.request == "attach" then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	else
		cb({
			type = "executable",
			command = getVenv(),
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			},
		})
	end
end

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = getVenv(),
	},
	{
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "proj",
		program = "src", --util.root_pattern('pyproject.toml')() .. '/src/__main__.py'; -- This configuration will launch the current file if used.
		pythonPath = getVenv(),
	},
	{
		type = "python",
		request = "launch",
		name = "Launch file (jmc=f)",
		program = "${file}", -- This configuration will launch the current file if used.
		justMyCode = false,
		pythonPath = getVenv(),
	},
	{
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "proj (jmc=f)",
		program = "src", --util.root_pattern('pyproject.toml')() .. '/src/__main__.py'; -- This configuration will launch the current file if used.
		justMyCode = false,
		pythonPath = getVenv(),
	},
}
local function get_maingo(workspace)
	local match = vim.fn.glob(path.join(vim.fn.getcwd(), "*", "main.go"))
	if match ~= "" then
		return match
	end
	match = vim.fn.glob(path.join(vim.fn.getcwd(), "main.go"))
	if match ~= "" then
		return match
	end

	return vim.fn.input("main go: ", "", "file")
end

require("dap-go").setup({
	dap_configurations = {
		{
			type = "go",
			name = "Attach remote",
			mode = "remote",
			request = "attach",
		},
		{
			type = "go",
			name = "maingo",
			request = "launch",
			program = get_maingo,
			buildFlags = "",
		},
	},
	delve = {
		path = "dlv",
		initialize_timeout_sec = 20,
		port = "${port}",
		args = {},
		build_flags = "",
		detached = true,
		cwd = nil,
	},
})

local dapui = require("dapui")
dapui.setup()
-- this anon function shit is needed to jump into floating windows once they are open
map("n", "<leader>R", dapui.toggle, opts) -- open many dapui windows to see my stupid code working
map("n", "<leader>E", function()
	dapui.eval()
	dapui.eval()
end, opts) -- evaluate expression
map("v", "<leader>E", function()
	dapui.eval()
	dapui.eval()
end, opts) -- evaluate expression in chunks with visual mode
map("n", "<leader>r", function()
	dapui.float_element("repl", { width = 200, heigh = 100 })
end, opts) -- open floating repl - sounds convenient
map("n", "<leader>fq", function()
	dapui.float_element("breakpoints")
	dapui.float_element("breakpoints")
end, opts) -- open floating breakpoints pane
map("n", "<leader>fw", function()
	dapui.float_element("watches")
	dapui.float_element("watches")
end, opts) -- open floating breakpoints pane
map("n", "<leader>fs", function()
	dapui.float_element("stacks")
	dapui.float_element("stacks")
end, opts) -- open floating stack pane
map("n", "<leader>fe", function()
	dapui.float_element("scopes")
	dapui.float_element("scopes")
end, opts) -- open floating variable scopes pane

require("neotest").setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
			runner = "pytest",
			python = getVenv(),
			pytest_discover_instances = true,
		}),
	},
})

local nt = require("neotest")

map("n", "<leader>nto", function()
	nt.output.open()
end, opts)
map("n", "<leader>ntO", function()
	nt.output_panel.open()
end, opts)
map("n", "<leader>ntr", function()
	nt.run.run()
end, opts)
map("n", "<leader>ntR", function()
	nt.run.run(vim.fn.expand("%"))
end, opts)
map("n", "<leader>ntd", function()
	nt.run.run({ strategy = "dap" })
end)
map("n", "<leader>nts", function()
	nt.summary.open()
end, opts)
