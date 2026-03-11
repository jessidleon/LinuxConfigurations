require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- LSP
map("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- move lines 
map("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map("n", "<CR>", "o<Esc>", { desc = "Insert line below" })

-- line duplication
map("n", "<A-S-Up>", "yyP", { desc = "Duplicate line up" })
map("n", "<A-S-Down>", "yyp", { desc = "Duplicate line down" })
map("v", "<A-S-Up>", "y'<P", { desc = "Duplicate selection up" })
map("v", "<A-S-Down>", "y'>p", { desc = "Duplicate selection down" })

--telescope
map("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", { desc = "Find references" })
map("n", "<leader>fd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Find definitions" })
map("n", "<leader>fi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Find implementations" })

--inlay_hint
vim.keymap.set("n", "<leader>uh", function()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
end, { desc = "Toggle inlay hints" })

-- aerials
vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>", { desc = "Outline" })

-- 
map("i", "<A-BS>", "<C-w>", { desc = "Delete previous word" })

-- dap
local dap = require("dap")
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)

--clangd-extension
vim.keymap.set("n", "<leader>cH", "<cmd>ClangdSwitchSourceHeader<CR>", { desc = "Switch header/source" })
vim.keymap.set("n", "<leader>cA", "<cmd>ClangdAST<CR>", { desc = "Clangd AST" })
vim.keymap.set("n", "<leader>ct", "<cmd>ClangdTypeHierarchy<CR>", { desc = "Type hierarchy" })

-- clangd: mostrar info/tipo del símbolo bajo el cursor
map("n", "gh", "<cmd>ClangdSymbolInfo<CR>", { desc = "Clangd symbol info" })

-- peek definition / declaration / implementation / references
map("n", "gpd", function()
  require("goto-preview").goto_preview_definition()
end, { desc = "Peek definition" })

map("n", "gpD", function()
  require("goto-preview").goto_preview_declaration()
end, { desc = "Peek declaration" })

map("n", "gpi", function()
  require("goto-preview").goto_preview_implementation()
end, { desc = "Peek implementation" })

map("n", "gpr", function()
  require("goto-preview").goto_preview_references()
end, { desc = "Peek references" })

map("n", "gpt", function()
  require("goto-preview").goto_preview_type_definition()
end, { desc = "Peek type definition" })

map("n", "<leader>pc", function()
  require("goto-preview").close_all_win()
end, { desc = "Close preview windows" })

-- diagnostics
map("n", "gl", function()
  vim.diagnostic.open_float(nil, { scope = "line", border = "rounded" })
end, { desc = "Line diagnostics" })

map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
