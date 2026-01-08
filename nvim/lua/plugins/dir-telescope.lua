return {
  'princejoogie/dir-telescope.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('telescope').load_extension('dir')
  end,
}
