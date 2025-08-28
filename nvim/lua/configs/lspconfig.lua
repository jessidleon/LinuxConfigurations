-- Carga defaults de NvChad (capabilities, on_attach, etc.)
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")
local nvlsp = require("nvchad.configs.lspconfig")

-- Servidores “genéricos” con config por defecto
local servers = { "clangd", "cmake" }  -- <-- quita "markdown" aquí
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
-- 🔧 markdown-oxide
lspconfig.markdown_oxide.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "markdown", "markdown.mdx" },
  root_dir = function(fname)
    local util = require("lspconfig.util")
    local real = vim.loop.fs_realpath(fname) or fname
    return util.root_pattern(".git")(real) or util.path.dirname(real)
  end,
  single_file_support = true,
  -- cmd = { vim.fn.stdpath("data") .. "/mason/bin/markdown-oxide" }, -- solo si el PATH no lo encuentra
}
