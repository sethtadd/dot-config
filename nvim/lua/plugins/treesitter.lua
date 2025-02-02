return {
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    opts = {
      -- NOTE: latex seems to need to be manually installed, it requires an `npm install -g tree-sitter-cli` then `:TSInstall latex`.
      -- NOTE: Maybe none of these are getting auto-installed; I just had to manually install cpp as well with `TSInstall cpp`.
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "javascript", "typescript", "cpp", "latex" },
      auto_install = true,
      fold = { enable = true },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown", "markdown_inline" },
      },
      incremental_selection = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,             -- Automatically jump forward to textobj
          keymaps = {
            ['af'] = '@function.outer', -- Around function
            ['if'] = '@function.inner', -- Inner function
            ['ac'] = '@class.outer',    -- Around class
            ['ic'] = '@class.inner',    -- Inner class
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- Adds movements to the jumplist
          goto_next_start = {
            [']f'] = '@function.outer',
            [']c'] = '@class.outer',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']C'] = '@class.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[c'] = '@class.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[C'] = '@class.outer',
          },
        },
      },
    },
  },

  -- Text objects
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'BufReadPost',
    dependencies = 'nvim-treesitter/nvim-treesitter',
  },

}
