return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  opts = {},
  config = function()
    require("ufo").setup({
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
    })
  end,
}
