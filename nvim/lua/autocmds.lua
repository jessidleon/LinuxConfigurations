require "nvchad.autocmds"
local api = vim.api

api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    if client:supports_method "textDocument/documentHighlight" then
      local group = api.nvim_create_augroup("lsp_document_highlight", { clear = false })

      api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = group,
        buffer = ev.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = group,
        buffer = ev.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

local function set_dap_breakpoint_style()
  vim.api.nvim_set_hl(0, "DapBreakpoint", {
    fg = "#ff5555",
    bg = "NONE",
    bold = true,
  })

  -- vim.api.nvim_set_hl(0, "DapBreakpointLine", {
  --   bg = "#F3FFC4",
  -- })

  vim.fn.sign_define("DapBreakpoint", {
    -- text = "●", -- si usas Nerd Font puedes probar ""
    text = "|→", -- si usas Nerd Font puedes probar ""
    texthl = "DapBreakpoint",
    linehl = "DapBreakpointLine",
    -- numhl = "DapBreakpoint",
  })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_dap_breakpoint_style,
})

set_dap_breakpoint_style()
