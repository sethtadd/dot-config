return {
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000, -- milliseconds (default is 5000)
      stages = "static", -- "fade", "slide", "fade_in_slide_out", "static"
      render = "compact", -- "default", "minimal", "simple", "compact"
      top_down = false, -- false for bottom-up
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },
}
