local wk = require("which-key")
local cmp = require 'cmp'

wk.add({
  {
    mode = { "n" },

    -- Navigate between windows
    { "<C-h>",             "<C-w>h",                                                desc = "Navigate Left" },
    { "<C-j>",             "<C-w>j",                                                desc = "Navigate Down" },
    { "<C-k>",             "<C-w>k",                                                desc = "Navigate Up" },
    { "<C-l>",             "<C-w>l",                                                desc = "Navigate Right" },
    -- Moving between splits
    { "<A-h>",             "<cmd>lua require('smart-splits').resize_left()<CR>",    desc = "Resize Left" },
    { "<A-j>",             "<cmd>lua require('smart-splits').resize_down()<CR>",    desc = "Resize Down" },
    { "<A-k>",             "<cmd>lua require('smart-splits').resize_up()<CR>",      desc = "Resize Up" },
    { "<A-l>",             "<cmd>lua require('smart-splits').resize_right()<CR>",   desc = "Resize Right" },
    -- Swapping buffers between windows
    { "<leader><leader>h", "<cmd>lua require('smart-splits').swap_buf_left()<CR>",  desc = "Swap Buffer Left" },
    { "<leader><leader>j", "<cmd>lua require('smart-splits').swap_buf_down()<CR>",  desc = "Swap Buffer Down" },
    { "<leader><leader>k", "<cmd>lua require('smart-splits').swap_buf_up()<CR>",    desc = "Swap Buffer Up" },
    { "<leader><leader>l", "<cmd>lua require('smart-splits').swap_buf_right()<CR>", desc = "Swap Buffer Right" },
  },

  -- NORMAL and VISUAL modes
  {
    mode = { "n", "v" },
    -- General
    { "<leader>q",   "<cmd>q<cr>",                                                           desc = "Quit" },
    { "<leader>w",   "<cmd>w<cr>",                                                           desc = "Write" },

    -- Oil
    { "<leader>o",   "<cmd>Oil<cr>",                                                         desc = "Open Oil File Browser" },

    -- Leap
    { "s",           "<Plug>(leap)",                                                         desc = "Leap Forward" },

    -- Telescope
    { "<leader>s",   group = "search" },
    { "<leader>sf",  "<cmd>Telescope find_files<cr>",                                        desc = "Find Files" },
    { "<leader>sg",  "<cmd>Telescope live_grep<cr>",                                         desc = "Live Grep" },
    { "<leader>sb",  "<cmd>Telescope buffers<cr>",                                           desc = "List Buffers" },
    { "<leader>so",  "<cmd>Telescope oldfiles<cr>",                                          desc = "Find Old Files" },
    { "<leader>sn",  "<cmd>Telescope notify<cr>",                                            desc = "Notifications" },
    { "<leader>sd",  group = "directory" },
    { "<leader>sdg", "<cmd>Telescope dir live_grep<cr>",                                     desc = "Live Grep in Directory" },
    { "<leader>sdf", "<cmd>Telescope dir find_files<cr>",                                    desc = "Find Files in Directory" },

    -- Zk
    -- https://github.com/zk-org/zk-nvim#example-mappings
    { "<leader>z",   group = "zk" },
    { "<leader>zn",  group = "New Note" },
    { "<leader>zne", "<cmd>ZkNew { title = vim.fn.input('Title: '), dir = 'ephemeral'}<cr>", desc = "New Ephemeral Note" },
    { "<leader>znr", "<cmd>ZkNew { title = vim.fn.input('Title: '), dir = 'reference'}<cr>", desc = "New Reference Note" },
    { "<leader>znj", "<cmd>ZkNew { title = vim.fn.input('Title: '), dir = 'journal'}<cr>",   desc = "New Journal Note" },
    { "<leader>znw", "<cmd>ZkNew { title = vim.fn.input('Title: '), dir = 'work'}<cr>",      desc = "New Work Note" },
    { "<leader>zo",  "<cmd>Telescope zk notes<cr>",                                          desc = "Open Notes" },
    { "<leader>zt",  "<cmd>Telescope zk tags<cr>",                                           desc = "Tags" },
    { "<leader>zb",  "<cmd>ZkBacklinks<cr>",                                                 desc = "Backlinks" },
    { "<leader>zl",  "<cmd>ZkLinks<cr>",                                                     desc = "Links" },
    { "<leader>zi",  ":'<,'>ZkInsertLinkAtSelection<cr>",                                    desc = "Insert Link At Selection" },

    -- LSP actions
    -- Override "[d and ]d to show the diagnostic floating window
    { "[d",          function() vim.diagnostic.jump({ count = -1, float = true }) end,       desc = "Previous Diagnostic" },
    { "]d",          function() vim.diagnostic.jump({ count = 1, float = true }) end,        desc = "Next Diagnostic" },
    -- Override "gd" and "gD" to use LSP definitions and declarations
    { "gd",          function() vim.lsp.buf.definition() end,                                desc = "Goto Definition" },
    { "gD",          function() vim.lsp.buf.declaration() end,                               desc = "Goto Declaration" },

    -- Git actions
    { "<leader>g",   group = "Git" },
    {
      "<leader>gd",
      function()
        vim.ui.input({ prompt = "Revision: " }, function(rev)
          if rev then vim.cmd("leftabove Gvdiffsplit " .. rev) end
        end)
      end,
      desc = "Git Diff"
    },
    { "<leader>gs", "<cmd>Git<CR>",                                     desc = "Git Status" },
    { "<leader>gb", "<cmd>Git blame<CR>",                               desc = "Git Blame" },
    -- Gitsigns
    { "]c",   "<cmd>Gitsigns nav_hunk next<CR>",                                                                   desc = "Next Change" },
    { "[c",   "<cmd>Gitsigns nav_hunk prev<CR>",                                                                   desc = "Previous Change" },


    -- Key mappings for toggleterm
    { "<C-\\>",     "<cmd>exe v:count1 . 'ToggleTerm'<CR>",             desc = "Toggle Terminal" },
    { "<leader>st", "<cmd>TermSelect<CR>",                              desc = "Select Terminal" },

    -- Key mappings for nabla.nvim
    { "<leader>p",  "<cmd>lua require'nabla'.popup()<CR>",              desc = "Nabla Popup" },
    { "<leader>n",  "<cmd>lua require('nabla').toggle_virt()<CR>",      desc = "Toggle Nabla Inline Rendering" },
    -- render-markdown.nvim
    { "<leader>m",  "<cmd>lua require('render-markdown').toggle()<CR>", desc = "Toggle Render Markdown" },

    -- Treesitter textobjects (main branch API)
    {
      -- Moving between function/class text objects
      { "]f", "<cmd>lua require'nvim-treesitter-textobjects.move'.goto_next_start('@function.outer')<CR>",     desc = "Next Function Start" },
      { "]F", "<cmd>lua require'nvim-treesitter-textobjects.move'.goto_next_end('@function.outer')<CR>",       desc = "Next Function End" },
      { "[f", "<cmd>lua require'nvim-treesitter-textobjects.move'.goto_previous_start('@function.outer')<CR>", desc = "Previous Function Start" },
      { "[F", "<cmd>lua require'nvim-treesitter-textobjects.move'.goto_previous_end('@function.outer')<CR>",   desc = "Previous Function End" },
    },
  },

  -- Treesitter text object selection mappings
  {
    mode = { "o" }, -- Operator-pending mode only, allows daf, yaf, caf, etc.
    { "af", "<cmd>lua require'nvim-treesitter-textobjects.select'.select_textobject('@function.outer')<CR>", desc = "Around Function" },
    { "if", "<cmd>lua require'nvim-treesitter-textobjects.select'.select_textobject('@function.inner')<CR>", desc = "Inside Function" },
    { "ac", "<cmd>lua require'nvim-treesitter-textobjects.select'.select_textobject('@class.outer')<CR>",    desc = "Around Class" },
    { "ic", "<cmd>lua require'nvim-treesitter-textobjects.select'.select_textobject('@class.inner')<CR>",    desc = "Inside Class" },
  },

  -- Terminal mode
  {
    mode = { "t" },
    {
      "<C-\\>",
      function()
        local terms = require('toggleterm.terminal').get_all()
        for _, term in ipairs(terms) do
          if term.bufnr == vim.api.nvim_get_current_buf() then
            term:toggle()
            return
          end
        end
      end,
      desc = "Toggle Terminal",
    },
    { "<esc>", [[<C-\><C-n>]], desc = "Normal Mode" },
  },
})

-- Key mappings for nvim-cmp
wk.add({
  -- INSERT mode
  {
    mode = { "i" },
    {
      {
        "<C-Space>",
        function()
          cmp.complete()
        end,
        desc = "Trigger Completion"
      },
      {
        "<C-n>",
        function()
          if cmp.visible() then
            cmp.select_next_item()
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n", true)
          end
        end,
        desc = "Next Completion Item"
      },
      {
        "<C-p>",
        function()
          if cmp.visible() then
            cmp.select_prev_item()
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n", true)
          end
        end,
        desc = "Previous Completion Item"
      },
      {
        "<C-f>",
        function()
          if cmp.visible() then
            cmp.scroll_docs(4)
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-f>", true, true, true), "n", true)
          end
        end,
        desc = "Scroll Documentation Down"
      },
      {
        "<C-b>",
        function()
          if cmp.visible() then
            cmp.scroll_docs(-4)
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-b>", true, true, true), "n", true)
          end
        end,
        desc = "Scroll Documentation Up"
      },
      {
        "<C-y>",
        function()
          if cmp.visible() and cmp.get_selected_entry() then
            cmp.confirm({ select = true })
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-y>", true, true, true), "n", true)
          end
        end,
        desc = "Confirm Completion"
      },
      {
        "<C-m>",
        function()
          if cmp.visible() and cmp.get_selected_entry() then
            cmp.confirm({ select = true })
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-y>", true, true, true), "n", true)
          end
        end,
        desc = "Confirm Completion"
      },
      {
        "<C-e>",
        function()
          if cmp.visible() then
            cmp.abort()
          else
            return vim.api.nvim_replace_termcodes("<C-e>", true, true, true)
          end
        end,
        desc = "Abort Completion"
      },
    },
  },
})

-- Don't lose focus on the quickfix list when opening an entry
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR><C-w>p", { buffer = true, silent = true, desc = "Open entry and keep focus" })
  end,
})
