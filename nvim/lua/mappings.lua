require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "Buscar referencias LSP" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Renombrar variable" })
map("n", "<A-up>", ":m .-2<CR>==", { desc = "Mover línea arriba", silent = true })
map("n", "<A-down>", ":m .+1<CR>==", { desc = "Mover línea abajo", silent = true })
map("v", "<A-up>", ":m '<-2<CR>gv=gv", { desc = "Mover bloque arriba", silent = true })
map("v", "<A-down>", ":m '>+1<CR>gv=gv", { desc = "Mover bloque abajo", silent = true })
map("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle árbol de archivos", silent = true })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

map("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, { desc = "Git preview hunk" })

local dap = require("dap")
local dapui = require("dapui")

map("n", "<F5>", dap.continue, { desc = "Iniciar / continuar debug" })
map("n", "<F10>", dap.step_over, { desc = "Step over" })
map("n", "<F11>", dap.step_into, { desc = "Step into" })
map("n", "<F12>", dap.step_out, { desc = "Step out" })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
map("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
map("n", "<CR>", ':call append(line("."), "") | normal! j<CR>', { noremap = true, silent = true, desc = "insert new line and move cursor down" })
map('i', '<M-BS>', '<C-w>', { noremap = true })
map("n", "<leader>p", '"_dP', { desc = 'Paste over without yanking replaced text'})
map('n', '<leader>D', vim.lsp.buf.hover, { silent = true, buffer = 0, desc = 'LSP Hover' })
-- map("v", "<leader>p", '"_dP', { desc = 'Paste over without yanking replaced text'})
map('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
map('n', 'x', '"_x')
map('n', 'X', '"_X')
map('n', 'dd', '"_dd')
map('n', 'D', '"_D')
-- map('v', 'd', '"_d')
-- map('v', 'c', '"_c')
