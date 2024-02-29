dap = require("dap")
local util = require('lspconfig/util')
local opts = { noremap=true, silent=true }
map = vim.keymap.set

map('n', 'B', dap.toggle_breakpoint, opts) -- set/remove breakpoint
map('n', '<leader>c', dap.continue, opts)
map('n', '<leader>x', dap.terminate, opts)
map('n', 'F', dap.step_over, opts) -- dont know what is it
map('n', '<leader>F', dap.step_into, opts) -- step into (a function)
map('n', '<leader>u', dap.step_out, opts) -- step out (of a function)

dap.repl.omnifunc = vim.lsp.omnifunc

local getVenv = function()
  local cwd = vim.fn.getcwd()
  local envPath = os.getenv("VIRTUAL_ENV")
  if vim.fn.executable(envPath .. '/bin/python') == 1 then
    return envPath .. '/bin/python'
  elseif vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
    return cwd .. '/venv/bin/python'
  elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
    return cwd .. '/.venv/bin/python'
  else
    return '/usr/bin/python'
  end
end

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/asu/miscellaneous/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = getVenv(),
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end

dap.configurations.python = {
  {
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "proj";
    
    program = "src"; --util.root_pattern('pyproject.toml')() .. '/src/__main__.py'; -- This configuration will launch the current file if used.
    pythonPath = getVenv;
  },
  -- this was an attempt to run tests in debugger
  -- {
  --   type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
  --   request = 'launch';
  --   name = "test";
  --   
  --   program = "-m pytest"; --util.root_pattern('pyproject.toml')() .. '/src/__main__.py'; -- This configuration will launch the current file if used.
  --   pythonPath = getVenv;
  -- },
}

--i will never remember this many hotkeys

dapui = require("dapui")
dapui.setup()
-- this anon function shit is needed to jump into floating windows once they are open
map('n', '<leader>R', dapui.toggle, opts) -- open many dapui windows to see my stupid code working
map('n', '<leader>E', function() dapui.eval(); dapui.eval() end, opts) -- evaluate expression
map('v', '<leader>E', function() dapui.eval(); dapui.eval() end, opts) -- evaluate expression in chunks with visual mode
map('n', '<leader>r', function() dapui.float_element("repl")  end, opts) -- open floating repl - sounds convenient
map('n', '<leader>fq', function() dapui.float_element("breakpoints"); dapui.float_element("breakpoints") end, opts) -- open floating breakpoints pane
map('n', '<leader>fw', function() dapui.float_element("watches"); dapui.float_element("watches")end, opts) -- open floating breakpoints pane
map('n', '<leader>fs', function() dapui.float_element("stacks"); dapui.float_element("stacks") end, opts) -- open floating stack pane
map('n', '<leader>fe', function() dapui.float_element("scopes"); dapui.float_element("scopes") end, opts) -- open floating variable scopes pane
