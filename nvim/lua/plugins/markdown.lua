return {
  -- Render inline en el buffer
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons", -- iconos (NvChad ya lo suele traer)
    },
    opts = {}, -- valores por defecto ya funcionan bien
    keys = {
      { "<leader>mt", "<cmd>RenderMarkdown toggle<cr>", desc = "Render Markdown (toggle)" },
      { "<leader>me", "<cmd>RenderMarkdown enable<cr>", desc = "Render Markdown (enable)" },
      { "<leader>md", "<cmd>RenderMarkdown disable<cr>", desc = "Render Markdown (disable)" },
    },
  },

  -- (Opcional) Vista previa completa en un panel TUI
  {
    "ellisonleao/glow.nvim",
    ft = { "markdown" },
    cmd = "Glow",
    config = true, -- defaults
    keys = {
      { "<leader>mp", "<cmd>Glow<cr>", desc = "Markdown preview (Glow)" },
    },
  },
}

