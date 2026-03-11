return {
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen" },
    opts = {

      layout = {
        max_width = { 80, 0.2 },
        min_width = 60,
      },
      filter_kind = {
        "Class",
        "Struct",
        "Function",
        "Method",
        "Constructor",
        "Enum",
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
