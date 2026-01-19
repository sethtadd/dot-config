-- Find npm project binaries
local function npm_bin(ctx, bin)
  if not ctx.filename or ctx.filename == "" then
    return nil
  end
  local root = vim.fs.root(ctx.filename, { "package.json" })
  if not root then
    return nil
  end
  local p = root .. "/node_modules/.bin/" .. bin
  if vim.uv.fs_stat(p) then
    return p
  end
  return nil
end

-- Only return command if binary exists
local function npm_formatter(bin)
  return {
    command = function(_, ctx)
      return npm_bin(ctx, bin) or bin -- string required (e.g. :ConformInfo)
    end,
    condition = function(_, ctx)
      return npm_bin(ctx, bin) ~= nil -- blocks PATH fallback
    end,
  }
end

return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = { timeout_ms = 2000, lsp_fallback = "never" },
    -- Override formatter resolution (avoid looking on PATH)
    -- We only want to run these formatters if they're provided by the project
    formatters = {
      biome = npm_formatter("biome"),
      prettierd = npm_formatter("prettierd"),
      prettier = npm_formatter("prettier"),
    },
    formatters_by_ft = {
      -- Provided by OS
      c = { "clang_format" },
      cpp = { "clang_format" },
      cuda = { "clang_format" },

      -- Provided by repo (Conform knows where to look relative to project root)
      javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
      typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
      json = { "biome", "prettierd", "prettier", stop_after_first = true },
      jsonc = { "biome", "prettierd", "prettier", stop_after_first = true },

      -- Provided by Mason
      lua = { "stylua" },
    },
  },
}
