return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      local function get_program()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end

      local function get_args()
        local input = vim.fn.input "Args: "

        if input == nil or vim.trim(input) == "" then
          return {}
        end

        return vim.split(vim.trim(input), "%s+", {
          trimempty = true,
        })
      end

      dapui.setup {
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.40 },
              -- { id = "breakpoints", size = 0.20 },
              { id = "stacks", size = 0.20 },
              { id = "watches", size = 0.20 },
            },
            size = 50,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.50 },
              { id = "console", size = 0.50 },
            },
            size = 12,
            position = "bottom",
          },
        },
      }

      require("nvim-dap-virtual-text").setup {
        commented = true,
      }

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = get_program,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = get_args,
          runInTerminal = false,
        },
      }

      dap.configurations.c = dap.configurations.cpp
    end,
  },
}
