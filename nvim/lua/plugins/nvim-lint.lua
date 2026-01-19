return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint" },
      typescript = { "eslint" },
      javascriptreact = { "eslint" },
      typescriptreact = { "eslint" },

      -- NOTE: cpp linting handled by clangd
      -- NOTE: latest biomejs has a bug causing it to not produce diagnostics
      -- https://github.com/mfussenegger/nvim-lint/issues/874
    }

    local aug = vim.api.nvim_create_augroup("Lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = aug,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
