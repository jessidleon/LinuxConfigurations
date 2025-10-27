return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim"
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      local function find_codelldb()
        local mason_adapter = vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/adapter/codelldb"
        if vim.loop.fs_stat(mason_adapter) then
          return mason_adapter
        end

        local in_path = vim.fn.exepath "codelldb"
        if in_path ~= "" then
          return in_path
        end
        return nil
      end

      local codelldb_cmd = find_codelldb()
      if not codelldb_cmd then
        vim.notify(
          "No encuentro el adapter 'codelldb'. Abre :Mason y instala 'codelldb', o añade codelldb al PATH.",
          vim.log.levels.ERROR
        )
        return
      end

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_cmd,
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.cpp = {
        {
          name = "Run (pick exe)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Ruta al ejecutable: ", vim.fn.getcwd() .. "/build/", "file")
          end,


-- program = "${workspaceFolder}/build/ur_test_joints/max_speed", 
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },

        {
          name = "Run (pick exe + args)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Ruta al ejecutable: ", vim.fn.getcwd() .. "/build/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = function()
            local line = vim.fn.input "Args: "
            return (line == "" and {}) or vim.fn.split(line, " ")
          end,
        },

        {
          name = "Run build/app (no args)",
          type = "codelldb",
          request = "launch",
          program = "${workspaceFolder}/build/",
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },

        {
          name = "Run build/app (TTY + args)",
          type = "codelldb",
          request = "launch",
          program = "${workspaceFolder}/build/",
          cwd = "${workspaceFolder}",
          runInTerminal = true,
          args = function()
            local line = vim.fn.input "Args: "
            return (line == "" and {}) or vim.fn.split(line, " ")
          end,
        },

{
  name = "Attach to PID (codelldb)",
  type = "codelldb",
  request = "attach",
  pid = function()
    return tonumber(vim.fn.input("PID: "))
  end,
  cwd = "${workspaceFolder}",
  -- Evita perderte en libc/stdlib al hacer step:
  initCommands = { "settings set target.process.thread.step-avoid-libraries true" },
},

{
  name = "Attach to PID (container)",
  type = "codelldb_direct",
  request = "attach",
  pid = function() return tonumber(vim.fn.input("PID: ")) end,
  cwd = "${workspaceFolder}",
  initCommands = {
    "settings set target.process.thread.step-avoid-libraries true",
    "settings set target.process.follow-fork-mode child", -- por si tu proceso hace fork/exec
  },
}, 

        {
          name = "Attach to process",
          type = "codelldb",

          request = "attach",
          pid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }

      dap.configurations.c = dap.configurations.cpp

      dapui.setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      local map = vim.keymap.set
      map("n", "<F5>", dap.continue, { desc = "DAP Continue" })
      map("n", "<F6>", dap.step_over, { desc = "DAP Step Over" })
      map("n", "<F7>", dap.step_into, { desc = "DAP Step Into" })
      map("n", "<F8>", dap.step_out, { desc = "DAP Step Out" })
      map("n", "<leader>tb", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })

      map("n", "E", function()
        dapui.eval()
      end, { desc = "DAP eval" })

-- Desactiva/activa breakpoints por excepción
vim.keymap.set("n", "<leader>de", function()
  require("dap").set_exception_breakpoints({})  -- OFF: no parar en throw/catch
  vim.notify("DAP: exception breakpoints OFF")
end)

vim.keymap.set("n", "<leader>dE", function()
  require("dap").set_exception_breakpoints({ "cpp_throw", "cpp_catch" }) -- ON si lo necesitas
  vim.notify("DAP: exception breakpoints ON (throw + catch)")
end)

-- Al iniciar una sesión, desactiva excepciones por defecto:
local dap = require("dap")
dap.listeners.after.event_initialized["no-exc"] = function()
  require("dap").set_exception_breakpoints({})
end




      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo" })
    end,
  },
}

