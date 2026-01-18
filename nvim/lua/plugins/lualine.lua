return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local colors = require('catppuccin.palettes').get_palette('mocha')

      local styled_terms = {
        function()
          local terms = require('toggleterm.terminal').get_all()
          return #terms .. '  '
        end,
        color = function()
          return { fg = colors.green, bg = colors.surface2 }
        end,
        -- cond = function()
        --   return #require('toggleterm.terminal').get_all() > 0
        -- end,
      }

      local styled_filename = {
        'filename',
        symbols = { modified = '●', readonly = '󰊪' },
        color = function()
          local bufnr = vim.fn.winbufnr(vim.g.statusline_winid)
          if vim.bo[bufnr].modified then return { fg = colors.red } end
        end,
      }

      require('lualine').setup({
        options = {
          theme = 'auto',
          globalstatus = true,

          section_separators = { left = '', right = '' },
          component_separators = { left = '|', right = '' }
        },

        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff' },
          lualine_c = { styled_filename },

          lualine_x = { 'diagnostics', 'lsp_status' },
          lualine_y = { 'searchcount', 'location', 'selectioncount' },
          lualine_z = {
            { 'tabs', symbols = { modified = ' ●' } },
            styled_terms
          }
        },
      })
    end,
  },
}
