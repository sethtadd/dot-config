return {
  { "jbyuki/nabla.nvim" }, -- Using nabla.nvim for latex rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      -- filetypes = { 'markdown' },
      latex = { enabled = false }, -- Play nice with nabla.nvim
      win_options = {
        conceallevel = {
          -- default = vim.api.nvim_get_option_value('conceallevel', {}),
          rendered = 2, -- <-- Play nice with nabla.nvim
        },
      },
      -- If there are rouge $'s in the markdown nabla will freak out, so don't tie nabla to render-markdown
      -- on = {
      --   attach = function()
      --     require('nabla').enable_virt({ autogen = true })
      --   end,
      -- },
    },
  },
}
