return {
  "mason-org/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  opts = {},
  config = function(_, opts)
    require("mason").setup(opts)

    require("mason-tool-installer").setup({
      ensure_installed = {
        -- LSPs
        "lua-language-server",
        "typescript-language-server", -- repos usually ship with tsserver, but we need the LSP wrapper since tsserver does not speak LSP (vscode can directly talk to tsserver)

        -- Formatters
        "stylua",
      },
      run_on_start = true,
      auto_update = false,
    })
  end,
}
