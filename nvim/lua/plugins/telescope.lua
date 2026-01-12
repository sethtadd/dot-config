return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },

  -- Override horizontal layout to remove titles
  config = function(_, opts)
    local horizontal = require('telescope.pickers.layout_strategies').horizontal
    require('telescope.pickers.layout_strategies').horizontal = function(picker, max_columns, max_lines, layout_config)
      local layout = horizontal(picker, max_columns, max_lines, layout_config)
      layout.prompt.title = ''
      layout.results.title = ''
      layout.preview.title = ''
      return layout
    end
    require('telescope').setup(opts)
  end,

  opts = {
    defaults = {
      borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      layout_config = {
        width = 0.90,
        height = 0.90,
        preview_width = 0.6,
        prompt_position = "top",
      },
      sorting_strategy = "ascending",
    },
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
