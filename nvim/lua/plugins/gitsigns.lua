return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add          = { text = '+' },
      change       = { text = '~' },
      delete       = { text = '-' },
      topdelete    = { text = '-' },
      changedelete = { text = '~' },
    },
    signs_staged = {
      add          = { text = '+' },
      change       = { text = '~' },
      delete       = { text = '-' },
      topdelete    = { text = '-' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      -- Catppuccin Mocha colored backgrounds for unstaged git signs
      vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#a6e3a1', bg = '#2d4f3c' })
      vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#f9e2af', bg = '#4d4528' })
      vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#f38ba8', bg = '#4d2d3a' })
      -- Subtle versions for staged signs (index vs HEAD) - no background
      vim.api.nvim_set_hl(0, 'GitSignsStagedAdd', { fg = '#5a7c5f' })
      vim.api.nvim_set_hl(0, 'GitSignsStagedChange', { fg = '#7a6a3d' })
      vim.api.nvim_set_hl(0, 'GitSignsStagedDelete', { fg = '#7a4d5a' })
    end,
  },
}
