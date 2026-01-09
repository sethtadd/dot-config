return {
  'b0o/incline.nvim',
  event = 'VeryLazy', -- Lazy load incline
  opts = {
    highlight = {
      groups = {
        InclineNormal = { guibg = '#45475a' }, -- Catppuccin surface1
        InclineNormalNC = { guibg = '#45475a' },
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
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
      -- local icon, color = require('nvim-web-devicons').get_icon_color(filename)

      local modified = vim.bo[props.buf].modified
      local readonly = vim.bo[props.buf].readonly

      local segments = {}

      if modified then
        table.insert(segments, { filename, guifg = '#f38ba8' })
      else
        table.insert(segments, { filename })
      end

      if readonly then
        table.insert(segments, { ' 󰊪 ' })
      end

      if modified then
        table.insert(segments, { ' ●', guifg = '#f38ba8' })
      end

      -- if icon and #icon then
      --   table.insert(segments, { ' ' })
      --   table.insert(segments, { icon, guifg = color })
      -- end

      return segments
    end,
  }
}
