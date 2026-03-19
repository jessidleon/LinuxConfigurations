return {
  {
    "juneedahamed/vc.vim",
    cmd = {
      "VCStatus",
      "VCLog",
      "VCDiff",
      "VCBlame",
      "VCInfo",
      "VCBrowse",
      "VCBrowseRepo",
      "VCBrowseWorkingCopy",
      "VCBrowseBookMarks",
      "VCCommit",
      "VCAdd",
      "VCRevert",
      "VCMove",
      "VCCopy",
    },
    init = function()
      vim.g.vc_signs = 1
      vim.g.vc_cache_dir = vim.fn.stdpath "cache"
      vim.g.vc_browse_cache_all = 1
      vim.g.vc_browse_bookmarks_cache = 1
      vim.g.vc_max_open_files = 20
    end,
  },

  {
    "mhinz/vim-signify",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.g.signify_vcs_list = { "svn" }
      vim.g.signify_number_highlight = 1
      vim.g.signify_line_highlight = 0
      vim.g.signify_cursorhold_normal = 1
      vim.g.signify_cursorhold_insert = 0

      vim.g.signify_sign_add = "│"
      vim.g.signify_sign_change = "│"
      vim.g.signify_sign_delete = "_"
      vim.g.signify_sign_delete_first_line = "‾"
    end,
  },
}
