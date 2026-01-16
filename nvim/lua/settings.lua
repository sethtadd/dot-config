-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2   -- Indent commands use 2 spaces
vim.opt.tabstop = 2      -- Display tabs as two spaces

-- Vim tabs
vim.opt.showtabline = 0 -- Never show tab line

-- Indenting
vim.opt.wrap = true -- Enable soft wrapping of long lines
vim.opt.breakindent = true -- Indent wrapped lines to align with the first line
vim.opt.showbreak = "╰─" -- Add some characters to the start of wrapped lines
vim.opt.linebreak = true -- When line wrapping, don't break in the middle of words

-- Folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()' -- Use Treesitter for folding
vim.opt.foldlevel = 99                          -- Start with all folds open

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<CR>')

-- Use smartcase when / searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable 24 bit RBG colors
vim.opt.termguicolors = true

-- Always show sign column for git signs
vim.opt.signcolumn = 'yes'

-- Show space characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Highlight cursor line
vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true

-- Don't show default mode text; shown by status line
vim.opt.showmode = false

-- Delay before showing diagnostics, linting errors, etc. Default is 4000
vim.opt.updatetime = 250

-- Show diagnostics as virtual text only, not in the sign column
vim.diagnostic.config({
  signs = false,
  virtual_text = true,
})



-- Save undo history
vim.opt.undofile = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Use system clipboard as default register, run async to reduce startup time
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    --  See `:help vim.highlight.on_yank()`
    vim.highlight.on_yank()
  end,
})

-- Border for all floating windows (diagnostics, completion, etc.)
vim.o.winborder = "single"
