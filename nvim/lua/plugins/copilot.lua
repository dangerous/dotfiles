return {
  'github/copilot.vim',
  event = 'VimEnter',
  config = function()
    -- Enable Copilot for specific filetypes
    vim.g.copilot_filetypes = {
      ['*'] = true,
    }
  end,
}
