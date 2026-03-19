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
  local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = 0 }
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
end, { desc = "Toggle inlay hints" })

-- aerials
vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>", { desc = "Outline" })

--
map("i", "<A-BS>", "<C-w>", { desc = "Delete previous word" })

-- dap
local dap = require "dap"
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F6>", dap.step_over)
vim.keymap.set("n", "<F7>", dap.step_into)
vim.keymap.set("n", "<F8>", dap.step_out)
vim.keymap.set("n", "<leader>B", dap.toggle_breakpoint)
vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "DAP repl" })
local dapui = require "dapui"
vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "DAP UI" })

map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "DAP continue" })

map("n", "<F6>", function()
  require("dap").step_over()
end, { desc = "DAP step over" })

map("n", "<F7>", function()
  require("dap").step_into()
end, { desc = "DAP step into" })

map("n", "<F8>", function()
  require("dap").step_out()
end, { desc = "DAP step out" })

map("n", "<Leader>B", function()
  require("dap").toggle_breakpoint()
end, { desc = "DAP toggle breakpoint" })

map("n", "<F9>", function()
  require("dap").terminate()
end, { desc = "DAP terminate" })

map("n", "<Leader>du", function()
  require("dapui").toggle()
end, { desc = "DAP toggle UI" })

map("n", "<Leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "DAP hover variable" })

map("n", "<Leader>dp", function()
  require("dap.ui.widgets").preview()
end, { desc = "DAP preview variable" })

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


-- svn
-- local opts = { noremap = true, silent = true }
-- local ropts = { silent = true, remap = true }

-- local function vc_input(prompt, cmd)
--   vim.ui.input({ prompt = prompt }, function(value)
--     if value and value ~= "" then
--       vim.cmd(cmd .. " " .. value)
--     end
--   end)
-- end

-- map("n", "<leader>vs", "<cmd>VCStatus<cr>", vim.tbl_extend("force", opts, { desc = "SVN status" }))
-- map("n", "<leader>vl", "<cmd>VCLog<cr>", vim.tbl_extend("force", opts, { desc = "SVN log archivo" }))
-- map("n", "<leader>vd", "<cmd>VCDiff<cr>", vim.tbl_extend("force", opts, { desc = "SVN diff actual" }))
-- map("n", "<leader>vD", function()
--   vc_input("Revision SVN: ", "VCDiff")
-- end, vim.tbl_extend("force", opts, { desc = "SVN diff revision" }))
-- map("n", "<leader>vb", "<cmd>VCBlame<cr>", vim.tbl_extend("force", opts, { desc = "SVN blame" }))
-- map("n", "<leader>vi", "<cmd>VCInfo<cr>", vim.tbl_extend("force", opts, { desc = "SVN info" }))
-- map("n", "<leader>vw", "<cmd>VCBrowseWorkingCopy<cr>", vim.tbl_extend("force", opts, { desc = "SVN browse wc" }))
-- map("n", "<leader>vR", "<cmd>VCBrowseRepo<cr>", vim.tbl_extend("force", opts, { desc = "SVN browse repo" }))
-- map("n", "<leader>vc", "<cmd>VCCommit<cr>", vim.tbl_extend("force", opts, { desc = "SVN commit" }))
-- map("n", "<leader>vr", "<cmd>VCRevert!<cr>", vim.tbl_extend("force", opts, { desc = "SVN revert actual" }))
-- map("n", "<leader>vn", "<plug>(signify-next-hunk)", vim.tbl_extend("force", ropts, { desc = "Siguiente cambio" }))
-- map("n", "<leader>vp", "<plug>(signify-prev-hunk)", vim.tbl_extend("force", ropts, { desc = "Cambio anterior" }))
-- map("n", "<leader>vh", "<cmd>SignifyHunkDiff<cr>", vim.tbl_extend("force", opts, { desc = "Preview hunk" }))
-- map("n", "<leader>vH", "<cmd>SignifyDiff<cr>", vim.tbl_extend("force", opts, { desc = "Diff buffer completo" }))
-- map("n", "<leader>vt", "<cmd>SignifyToggle<cr>", vim.tbl_extend("force", opts, { desc = "Toggle signify" }))
-- map("n", "<leader>vF", "<cmd>SignifyRefresh<cr>", vim.tbl_extend("force", opts, { desc = "Refresh signify" }))
