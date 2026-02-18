-- Robust clangd startup without nvim-lspconfig "framework"
-- Works in Neovim 0.11+ and avoids :LspStart / vim.lsp.enable issues.

local function clangd_path()
  local mason = vim.fn.stdpath("data") .. "/mason/bin/clangd"
  if vim.fn.executable(mason) == 1 then
    return mason
  end
  return "clangd"
end

local function buf_path(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if type(name) ~= "string" or name == "" then
    return nil
  end
  return vim.loop.fs_realpath(name) or name
end

local function dirname(path)
  if type(path) ~= "string" or path == "" then
    return nil
  end
  return vim.fs.dirname(path)
end

local function find_root(start_dir)
  if not start_dir then
    return vim.fn.getcwd()
  end

  local markers = {
    "compile_commands.json",
    "compile_flags.txt",
    ".clangd",
    ".git",
  }

  local found = vim.fs.find(markers, { path = start_dir, upward = true })[1]
  if found then
    return vim.fs.dirname(found)
  end

  return start_dir
end

local function make_capabilities()
  local ok, nvlsp = pcall(require, "nvchad.configs.lspconfig")
  if ok and nvlsp and nvlsp.capabilities then
    return nvlsp.capabilities
  end
  return vim.lsp.protocol.make_client_capabilities()
end

local function on_attach(client, bufnr)
  local ok, nvlsp = pcall(require, "nvchad.configs.lspconfig")
  if ok and nvlsp and nvlsp.on_attach then
    nvlsp.on_attach(client, bufnr)
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
  callback = function(args)
    local file = buf_path(args.buf)
    local root = find_root(dirname(file))

    vim.lsp.start({
      name = "clangd",
      cmd = {
        clangd_path(),
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
        "--fallback-style=LLVM",
        "--log=error",
        "--query-driver=/usr/bin/g++-11,/usr/bin/c++-11",
      },
      root_dir = root,
      capabilities = make_capabilities(),
      on_attach = on_attach,
      init_options = {
        fallbackFlags = { "-std=c++20" },
      },
    })
  end,
})
