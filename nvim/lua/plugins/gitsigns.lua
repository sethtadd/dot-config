return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add          = { text = '│' }, -- Vertical bar for additions
      change       = { text = '│' }, -- Vertical bar for changes
      delete       = { text = '│' }, -- Vertical bar for deletions
      topdelete    = { text = '┬' }, -- Top connector for deletions
      changedelete = { text = '│' }, -- Vertical bar for changed and deleted lines
    },
  },
}
