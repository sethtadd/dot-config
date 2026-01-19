-- init.lua

require('lazy_bootstrap')
require('settings')
require('keymaps')

vim.lsp.enable('luals')
vim.lsp.enable('clangd')
vim.lsp.enable('ts_ls')
