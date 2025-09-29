require("nvchad.configs.lspconfig").defaults()

local nvlsp = require("nvchad.configs.lspconfig")

local function cfg(name, opts)
  vim.lsp.config(name, vim.tbl_deep_extend("force", {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }, opts or {}))
end

cfg("clangd")
cfg("cmake")

-- 🔧 markdown-oxide 
cfg("markdown_oxide", {
  filetypes = { "markdown", "markdown.mdx" },
  single_file_support = true,
  root_dir = function(fname)
    local util = require("lspconfig.util") -- solo utilidad, no usa el “framework” viejo
    local real = vim.loop.fs_realpath(fname) or fname
    return util.root_pattern(".git")(real) or util.path.dirname(real)
  end,
})

vim.lsp.enable({ "clangd", "cmake", "markdown_oxide" })
