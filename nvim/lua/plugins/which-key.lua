-- I have a separate config.mappings file where I require which-key.
-- With lazy the plugin will be automatically loaded when it is required somewhere

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
    },
  },
}
