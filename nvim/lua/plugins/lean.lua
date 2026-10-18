return {
  "Julian/lean.nvim",
  event = { "BufReadPre *.lean", "BufNewFile *.lean" },
  init = function()
    -- lean.nvim starts its language server and infoview when opening Lean files.
    vim.g.lean_config = { mappings = true }
  end,
}
