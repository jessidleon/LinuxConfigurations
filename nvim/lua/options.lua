require "nvchad.options"

local opt = vim.opt
local api = vim.api

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "both"

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99

local function dynamic_highlights()
  local bg = vim.o.background

  api.nvim_set_hl(0, "IblScope", { fg = "#7aa2f7" })

  if bg == "light" then
    api.nvim_set_hl(0, "CursorLine", { bg = "#E8E8E8" })
    api.nvim_set_hl(0, "CursorLineNr", { fg = "#AF8700", bold = true })
    api.nvim_set_hl(0, "LineNr", { fg = "#000000", bold = true })
    api.nvim_set_hl(0, "Visual", { bg = "#CFCFCF" })
  else
    api.nvim_set_hl(0, "CursorLine", { bg = "#444C5E" })
    api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFD700", bold = true })
    api.nvim_set_hl(0, "LineNr", { fg = "#FFFFFF", bold = true })
    api.nvim_set_hl(0, "Visual", { bg = "#6c7086" })
  end
end

dynamic_highlights()

api.nvim_create_autocmd("ColorScheme", {
  callback = dynamic_highlights,
})

local api = vim.api

api.nvim_set_hl(0, "LspReferenceText", {
  bg = "#4a5270",
  bold = true,
})

api.nvim_set_hl(0, "LspReferenceRead", {
  bg = "#4a5270",
  bold = true,
})

api.nvim_set_hl(0, "LspReferenceWrite", {
  bg = "#6a4b5f",
  bold = true,
})
