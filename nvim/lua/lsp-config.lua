local lsp_zero = require("lsp-zero")
local util = require("lspconfig/util")

local path = util.path

lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<C-k>i", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<F2>", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end)

local function get_python_path()
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

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "pyright" },
	handlers = {
		lsp_zero.default_setup,
		vim.lsp.config("lua_ls", {}),
		vim.lsp.config("pyright", {
			root_dir = vim.fn.getcwd(),
			settings = { python = { analysis = { typeCheckingMode = "strict" } } },
			before_init = function(_, config)
				config.settings.python.pythonPath = get_python_path()
			end,
		}),
		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					codelenses = {
						gc_details = true,
						generate = true,
						regenerate_cgo = true,
						run_govulncheck = true,
						test = true,
						tidy = true,
						upgrade_dependency = true,
						vendor = true,
					},
					analyses = {
						nilness = true,
						unusedparams = true,
						unusedwrite = true,
						useany = true,
					},
					staticcheck = true,
				},
			},
		}),
		vim.lsp.config("lspconfig", {}),
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{
			name = "dotenv",
			option = {
				path = ".",
				load_shell = true,
			},
		},
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})
