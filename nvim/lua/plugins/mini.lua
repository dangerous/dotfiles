return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }

    require('mini.files').setup {
      mappings = {
        close = '<esc>',
      },
      windows = {
        preview = true,
        width_preview = 80,
      },
    }
    vim.keymap.set('n', '<leader>d', function()
      MiniFiles.open()
    end, { desc = 'File explorer' })

    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
