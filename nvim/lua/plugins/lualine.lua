return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'palenight',
      },

      sections = {
        lualine_x = { 'copilot' },
      },
    },
  },

  {
    'AndreM222/copilot-lualine',
  },
}
