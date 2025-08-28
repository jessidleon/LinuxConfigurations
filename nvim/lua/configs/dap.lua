local dap = require('dap')

-- Configurar el adaptador para C++ (cpptools)
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.fn.stdpath('data') .. '/mason/bin/OpenDebugAD7',  -- ruta al adaptador instalado por Mason
}

-- Configuraciones de depuración para C/C++
dap.configurations.cpp = {
  {
    name = "Iniciar programa (GDB)",
    type = "cppdbg",
    request = "launch",
    program = function()
      -- Pedir al usuario la ruta del ejecutable a depurar
      return vim.fn.input('Ruta al ejecutable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    MIMode = "gdb",
    miDebuggerPath = "/usr/bin/gdb",
    setupCommands = {  -- habilitar impresión bonita de STL en GDB
      {
        text = "-enable-pretty-printing",
        description = "Habilitar pretty printing",
        ignoreFailures = true
      }
    }
  }
}
-- Hacer que configuraciones de C sean las mismas que cpp (para archivos .c)
dap.configurations.c = dap.configurations.cpp
require('dapui').setup()  -- usar valores por defecto está bien

-- Abrir/cerrar la UI automáticamente al iniciar/terminar depuración
dap.listeners.after.event_initialized["dapui_config"] = function() require('dapui').open() end
dap.listeners.before.event_terminated["dapui_config"] = function() require('dapui').close() end
dap.listeners.before.event_exited["dapui_config"]     = function() require('dapui').close() end

