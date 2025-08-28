require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "Buscar referencias LSP" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Renombrar variable" })
vim.keymap.set("n", "<A-up>", ":m .-2<CR>==", { desc = "Mover línea arriba", silent = true })
vim.keymap.set("n", "<A-down>", ":m .+1<CR>==", { desc = "Mover línea abajo", silent = true })
vim.keymap.set("v", "<A-up>", ":m '<-2<CR>gv=gv", { desc = "Mover bloque arriba", silent = true })
vim.keymap.set("v", "<A-down>", ":m '>+1<CR>gv=gv", { desc = "Mover bloque abajo", silent = true })
vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle árbol de archivos", silent = true })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

vim.keymap.set("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, { desc = "Git preview hunk" })

local dap = require("dap")
local dapui = require("dapui")

vim.keymap.set("n", "<F5>", dap.continue, { desc = "Iniciar / continuar debug" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<CR>", ':call append(line(\'.\'), \'\')<CR>', { noremap = true, silent = true, desc="insert new line without entering in edit mode"})
