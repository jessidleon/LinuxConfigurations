return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
    lazy = false,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
    lazy = false,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "cpp",
        "cmake",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    enabled = true,
    lazy = false,
  }, -- cliente DAP principal
  {
    "rcarriga/nvim-dap-ui",
    enabled = true,
    lazy = false,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    enabled = true,
    lazy = false,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = false,
    enabled = true,
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
  },
}

