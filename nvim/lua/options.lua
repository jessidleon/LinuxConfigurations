require "nvchad.options"
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "both"

local api = vim.api
api.nvim_set_hl(0, "IblScope", { fg = "#7aa2f7" })
local function strong_cursorline()
  -- api.nvim_set_hl(0, "CursorLine", { bg = "#444c5e" })
  api.nvim_set_hl(0, "CursorLine", { bg = "#444C5E" })
  api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFD700", bold = true })
end
strong_cursorline()
api.nvim_create_autocmd("ColorScheme", { callback = strong_cursorline })
vim.api.nvim_set_hl(0, "Visual", { bg = "#6c7086" })
