return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      require("dapui").setup()
      -- require(dapui).setup()

      -- Detecta lldb-dap (nuevo) o lldb-vscode (antiguo)
      local lldb_cmd = vim.fn.exepath("lldb-vscode-14")
      if lldb_cmd == "" then
        lldb_cmd = vim.fn.exepath("lldb")
      end
      if lldb_cmd == "" then
        vim.notify("[dap] No encuentro lldb-dap/lldb-vscode en PATH. Instala 'lldb'.", vim.log.levels.ERROR)
        return
      end

      -- Adapter LLDB
      dap.adapters.lldb = {
        type = "executable",
        command = lldb_cmd,
        name = "lldb",
      }

      -- Config C/C++
      dap.configurations.cpp = {
        {
          name = "LLDB: Launch (build/app)",
          type = "lldb",
          request = "launch",
          program = function()
            local default = vim.fn.getcwd() .. "/build/app"
            if vim.fn.executable(default) == 1 or vim.fn.filereadable(default) == 1 then
              return default
            end
            return vim.fn.input("Ruta al ejecutable: ", default, "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
          runInTerminal = false, -- pon true si tu app necesita TTY (stdin)
        },
      }
      dap.configurations.c = dap.configurations.cpp

      -- UI
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- Teclas
      local map = vim.keymap.set
      map("n", "<F5>", dap.continue, { desc = "DAP Continue" })
      map("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
      map("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
      map("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
      map("n", "<leader>tb", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })

      -- Señales
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo" })
    end,
  },
}
