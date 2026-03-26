-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "oceanic-next",
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true , fg = "#808000"},
  },
}

M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazyload = false,
  },
}

M.term = {
  float = {
    relative = "editor",
    row = 0.1,
    col = 0.05,
    width = 0.9,
    height = 0.8,
    border = "single",
  },
}
return M
