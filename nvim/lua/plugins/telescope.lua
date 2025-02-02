return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    -- Delete buffers in buffer picker in normal mode: "dd"
    -- https://github.com/nvim-telescope/telescope.nvim/pull/828#issuecomment-857912430
    pickers = {
      buffers = {
        show_all_buffers = true,
        sort_lastused = true,
        -- theme = "dropdown",
        -- previewer = false, -- deleting buffers with preview enabled gives error
        mappings = {
          n = {
            ["dd"] = "delete_buffer",
          }
        }
      }
    }
  },
}
