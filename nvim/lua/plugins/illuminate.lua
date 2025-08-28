return {
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure {
        delay = 120,
        filetypes_denylist = { "NvimTree", "alpha", "dashboard", "cmake", "CMake" },
      }
    end,
    event = "VeryLazy",
  },
}
