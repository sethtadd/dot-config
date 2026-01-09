return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local colors = require('catppuccin.palettes').get_palette('mocha')

      require('lualine').setup({
        options = {
          theme = 'catppuccin',
          globalstatus = true,
        },

        sections = {
          lualine_c = {
            {
              'filename',
              symbols = { modified = '●', readonly = '󰊪' },
              color = function()
                local bufnr = vim.fn.winbufnr(vim.g.statusline_winid)
                if vim.bo[bufnr].modified then return { fg = colors.red } end
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
              cond = function()
                return #require('toggleterm.terminal').get_all() > 0
              end,
            },
            'copilot',
          },
        },
      })
    end,
  },

  {
    'AndreM222/copilot-lualine',
  },
}
