return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ["<C-h>"] = false, -- free it for window navigation
      ["<C-j>"] = false, -- free it for window navigation
      ["<C-k>"] = false, -- free it for window navigation
      ["<C-l>"] = false, -- free it for window navigation
    },
    delete_to_trash = true, -- Don't permanently delete files from oil
    watch_for_changes = true, -- Watch filesystem for changes and auto-reload oil
    view_options = { show_hidden = true },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
