return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        ruby = { 'rubocop' },
      }

      vim.g.lint_enabled = true

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.g.lint_enabled and vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })

      vim.keymap.set('n', '<leader>tl', function()
        vim.g.lint_enabled = not vim.g.lint_enabled
        if vim.g.lint_enabled then
          lint.try_lint()
        else
          vim.diagnostic.reset()
        end
      end, { desc = '[T]oggle [L]inting' })
    end,
  },
}
