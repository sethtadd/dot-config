-- Policy:
-- - typescript-language-server comes from Mason/OS PATH
-- - Only attach if the repo provides TypeScript (node_modules/typescript)
-- - Only attach if tsconfig/jsconfig exists

local function pkg_root(bufnr)
  return vim.fs.root(bufnr, { "package.json" })
end

local function exists(path)
  return path and vim.uv.fs_stat(path) ~= nil
end

local function has_repo_typescript(root)
  return exists(root .. "/node_modules/typescript")
end

local function has_ts_config(bufnr, root)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  if fname == "" then
    return false
  end

  local found = vim.fs.find({ "tsconfig.json", "jsconfig.json" }, {
    path = fname,
    upward = true,
    -- Stop *above* the root so the root directory itself is still searched.
    stop = vim.fs.dirname(root),
    type = "file",
    limit = 1,
  })[1]

  return found ~= nil
end

return {
  -- Match Neovim's standard filetypes
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },

  -- Attach only in Node packages that actually ship TypeScript.
  root_dir = function(bufnr, on_dir)
    local root = pkg_root(bufnr)
    if not root then
      vim.notify("ts_ls: no package.json found", vim.log.levels.WARN)
      return
    end

    if not has_repo_typescript(root) then
      vim.notify("ts_ls: no node_modules/typescript in " .. root, vim.log.levels.WARN)
      return
    end

    -- Only allow TS LSP for projects that have a tsconfig/jsconfig.
    if not has_ts_config(bufnr, root) then
      vim.notify("ts_ls: no tsconfig.json or jsconfig.json in " .. root, vim.log.levels.WARN)
      return
    end
    on_dir(root)
  end,

  -- Use Mason/OS-provided typescript-language-server from PATH.
  -- It will use the repo's TypeScript (tsserver) because of the root_dir guard above.
  cmd = { "typescript-language-server", "--stdio" },

  init_options = { hostInfo = "neovim" },

  -- Conform owns formatting (Biome/Prettier, etc.)
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
