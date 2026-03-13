require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls" }
vim.lsp.enable(servers)

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--function-arg-placeholders=true",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = {
    "compile_commands.json",
    "compile_flags.txt",
    ".git",
  },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  on_attach = function(client, bufnr)
    if client:supports_method "textDocument/inlayHint" then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
})
vim.lsp.enable "clangd"
