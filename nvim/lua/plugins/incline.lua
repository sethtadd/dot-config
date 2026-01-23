return {
  "b0o/incline.nvim",
  event = "VeryLazy",
  config = function()
    local colors = require("catppuccin.palettes").get_palette("mocha")

    require("incline").setup({
      highlight = {
        groups = {
          InclineNormal = { guibg = colors.surface1 },
          InclineNormalNC = { guibg = colors.surface1 },
        },
      },
      window = {
        padding = 5,
        margin = {
          vertical = {
            top = 0,
            bottom = 0,
          },
          horizontal = {
            left = 0,
            right = 0,
          },
        },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")

        local modified = vim.bo[props.buf].modified
        local readonly = vim.bo[props.buf].readonly

        local segments = {}

        if modified then
          table.insert(segments, { filename, guifg = colors.red })
        else
          table.insert(segments, { filename })
        end

        if readonly then
          table.insert(segments, { " 󰊪 " })
        end

        if modified then
          table.insert(segments, { " ●", guifg = colors.red })
        end

        return segments
      end,
    })
  end,
}
