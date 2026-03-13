return {
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local clangd_extensions = require "clangd_extensions"
      clangd_extensions.setup {
        inlay_hints = {
          inline = vim.fn.has "nvim-0.10" == 1,
        },
        ast = {
          role_icons = {
            type = "🄣",
            declaration = "🄓",
            expression = "🄔",
            statement = ";",
            specifier = "🄢",
            ["template argument"] = "🆃",
          },
        },
      }
    end,
  },
}
