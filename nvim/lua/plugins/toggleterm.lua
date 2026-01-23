return {
  "akinsho/toggleterm.nvim",
  version = "*", -- TODO: Is this needed?
  opts = {
    direction = "float",
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    float_opts = {
      title_pos = "center",
    },
    on_create = function(term)
      term.display_name = "Terminal " .. term.id
    end,
  },
}
