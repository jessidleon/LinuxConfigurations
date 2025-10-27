-- Carga defaults de NvChad (capabilities, on_attach, etc.)
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require("nvchad.configs.lspconfig")

-- Helper para aplicar tus overrides a una config existente
local function cfg(name, opts)
  vim.lsp.config(name, vim.tbl_deep_extend("force", {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }, opts or {}))
end

-- Servidores “genéricos” (usa las configs de nvim-lspconfig y solo añade tus defaults)
cfg("clangd")
cfg("cmake")

-- 🔧 markdown-oxide con overrides
cfg("markdown_oxide", {
  filetypes = { "markdown", "markdown.mdx" },
  single_file_support = true,
  -- Si el binario no está en PATH, descomenta:
  -- cmd = { vim.fn.stdpath("data") .. "/mason/bin/markdown-oxide" },
  root_dir = function(fname)
    local util = require("lspconfig.util") -- solo utilidad, no usa el “framework” viejo
    local real = vim.loop.fs_realpath(fname) or fname
    return util.root_pattern(".git")(real) or util.path.dirname(real)
  end,
})

-- Habilita las configs (actúan por filetype)
vim.lsp.enable({ "clangd", "cmake", "markdown_oxide" })
