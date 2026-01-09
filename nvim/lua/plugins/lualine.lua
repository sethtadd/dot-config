return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'palenight',
        globalstatus = true,
      },

      sections = {
        lualine_c = {
          {
            'filename',
            symbols = { modified = '●', readonly = '󰊪' },
            color = function()
              local bufnr = vim.fn.winbufnr(vim.g.statusline_winid)
              if vim.bo[bufnr].modified then return { fg = '#f38ba8' } end
            end,
          },
        },

        lualine_x = {
          {
            function()
              local terms = require('toggleterm.terminal').get_all()
              if #terms > 0 then return ' ' .. #terms end
              return ''
            end,
            -- only show when there are open terminals
            cond = function()
              return #require('toggleterm.terminal').get_all() > 0
            end,
          },
          'copilot',
        },
      },
    },
  },

  {
    'AndreM222/copilot-lualine',
  },
}
