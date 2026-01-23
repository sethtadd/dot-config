return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",

  config = function()
    local highlight = { "CursorColumn", "Whitespace" }

    require("ibl").setup({
      indent = {
        highlight = highlight,
        char = "", -- Set to empty if you don't want to show characters for indents
      },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false, -- Option to remove trailing blank lines, set to false
      },
      scope = {
        enabled = true, -- Enable scope highlighting
        highlight = { "CursorColumn", "Whitespace" }, -- Define the highlight groups for the scope
        include = {
          node_type = {
            "function",
            "class",
            "if",
            "while",
            "for",
          },
        },
      },
    })
  end,
}
