return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    custom_highlights = function(colors)
      return {
        WinSeparator = { fg = colors.surface2 },
      }
    end,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd([[colorscheme catppuccin-mocha]])
  end,
}
