-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(
---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "chadracula",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { fg = "#FFD700", italic = true },
    LineNr = { fg = "#999999" },
    CursorLineNr = { fg = "#FFD700", bold = true },
    Visual = { fg = "#0F00F3", bg = "#E3FEE1", bold = true, italic = true },
  },
}

M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazyload = false,
  },
}

return M
