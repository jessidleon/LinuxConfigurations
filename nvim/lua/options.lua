require "nvchad.options"

-- add yours here!

vim.o.cursorlineopt ='both' -- to enable cursorline!
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99
vim.o.relativenumber = true
vim.o.foldenable = true
vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#2929df" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#2929df" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#2929df" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#392a2a", underline = true })
vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#cccccc", fg = "#ffffff", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "#4a4a4a" })
