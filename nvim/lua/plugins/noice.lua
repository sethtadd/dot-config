return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      views = {
        hover = {
          border = { style = "single" },
        },
      },
      routes = {
        {
          filter = { event = "msg_show", kind = "search_count" },
          opts = { skip = true },
        },
      },
      lsp = {
        -- override = {
        --   ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        --   ["vim.lsp.util.stylize_markdown"] = true,
        --   ["cmp.entry.get_documentation"] = true,
        -- },
        --   signature = {
        --     enabled = false,
        --   },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
}
