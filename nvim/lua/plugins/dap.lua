return {
  -- Plugin base
  {
    "mfussenegger/nvim-dap",
    lazy = true,
  },

  -- UI para DAP (requiere nvim-nio ahora)
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio", -- <--- importante!
    },
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- Adaptador para GDB (como antes)
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.stdpath "data" .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Ruta al ejecutable: ", vim.fn.getcwd() .. "/", "file")
          end,
          --cwd = "${workspaceFolder}",
          cwd = vim.fn.expand "~/ros2_ws/build/loris/", -- ← esta línea fija la raíz del proceso
          stopAtEntry = true,
          setupCommands = {
            {
              text = "-enable-pretty-printing",
              description = "habilita pretty-printing",
              ignoreFailures = false,
            },
          },
        },
        {
          name = "Attach to process",
          type = "cppdbg",
          request = "attach",
          processId = require("dap.utils").pick_process,
          cwd = vim.fn.expand ("~/ros2_ws/build/loris/"),
          program = function()
            return vim.fn.input("Ruta al binario: ", "/home/jessid/ros2_ws/build/loris/" .. "/", "file")
          end,
          setupCommands = {
            {
              text = "-enable-pretty-printing",
              description = "habilita pretty-printing",
              ignoreFailures = false,
            },
          },
        },
      }

      dap.configurations.c = dap.configurations.cpp
    end,
  },
}
