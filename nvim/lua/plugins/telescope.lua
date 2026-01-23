return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

  -- Override horizontal layout to remove titles
  config = function(_, opts)
    local strategies = require("telescope.pickers.layout_strategies")
    local horizontal = strategies.horizontal

    -- Override the horizontal layout to remove section titles.
    --
    -- IMPORTANT:
    -- Telescope will *disable the preview pane* in smaller terminal windows
    -- (based on preview_cutoff / available columns).
    -- When this happens, `layout.preview` is set to `false` (a boolean),
    -- not a table. Indexing it without checking will crash Telescope:
    --   "attempt to index field 'preview' (a boolean value)"
    --
    -- In fullscreen terminals the preview exists and is a table, which is
    -- why this bug only showed up in non-fullscreen windows.
    strategies.horizontal = function(picker, max_columns, max_lines, layout_config)
      local layout = horizontal(picker, max_columns, max_lines, layout_config)

      -- These are always tables, but we guard anyway for safety
      if type(layout.prompt) == "table" then
        layout.prompt.title = ""
      end

      if type(layout.results) == "table" then
        layout.results.title = ""
      end

      -- Preview is sometimes `false`, so this MUST be guarded
      if type(layout.preview) == "table" then
        layout.preview.title = ""
      end

      return layout
    end

    require("telescope").setup(opts)
  end,

  opts = {
    defaults = {
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
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
          },
        },
      },
    },
  },
}
