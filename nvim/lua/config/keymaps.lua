local set = vim.keymap.set

set('n', '<Esc>', '<cmd>nohlsearch<CR>')
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

set('n', '<leader>v', '<cmd>e ~/.config/nvim/init.lua<CR>')
set('n', '<leader>V', '<cmd>e ~/.config/nvim/lua<CR>')

-- toggle the number and sign columns
set('n', '<leader>n', function()
  if vim.wo.number then
    vim.wo.number = false
    vim.wo.signcolumn = 'no'
    vim.cmd(pcall(require, 'ibl') and 'IBLDisable' or '')
  else
    vim.wo.number = true
    vim.wo.signcolumn = 'yes'
    vim.cmd(pcall(require, 'ibl') and 'IBLEnable' or '')
  end
end, { desc = 'Toggle line numbers and sign column' })

set('n', '<leader>w', function()
  vim.wo.wrap = not vim.wo.wrap
end, { noremap = true, silent = true, desc = 'Toggle Word Wrap' })

-- move virtually up and down wrapped lines, but use physical lines when used with a count
set('n', 'j', function()
  return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true, noremap = true, silent = true })
set('n', 'k', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true, noremap = true, silent = true })

-- yank to end of line (consistent with C and D)
set('n', 'Y', 'y$', { desc = 'Yank to end of line' })

-- git bindings
set('n', '<leader>m', '<cmd>GitMessenger<CR>', { desc = 'Git [M]essenger' })
set('n', '<leader>b', '<cmd>Git blame<CR>', { desc = 'Git [B]lame' })
set('n', '<leader>gs', '<cmd>G<CR>', { desc = '[G]it [S]tatus' })
set('n', '<leader>gj', '<cmd>diffget //3<CR>', { desc = 'Diffget right (//3)' })
set('n', '<leader>gf', '<cmd>diffget //2<CR>', { desc = 'Diffget left (//2)' })

-- comment toggle (neovim 0.10+ built-in gc/gcc)
set('n', '<leader>,', 'gcc', { remap = true, desc = 'Toggle comment' })
set('v', '<leader>,', 'gc', { remap = true, desc = 'Toggle comment' })

-- toggle listchars
set('n', '<leader>l', '<cmd>set list!<CR>', { desc = 'Toggle [L]istchars' })

-- yank to system clipboard
set({ 'n', 'v' }, '<leader>y', '"+y', { desc = '[Y]ank to system clipboard' })
set('n', '<leader>Y', '"+y$', { desc = '[Y]ank to end of line to system clipboard' })

-- window resizing
set('n', '+', '<cmd>resize +5<CR>', { desc = 'Increase window height' })
set('n', '-', '<cmd>resize -5<CR>', { desc = 'Decrease window height' })
set('n', '<leader>+', '<cmd>vertical resize +5<CR>', { desc = 'Increase window width' })
set('n', '<leader>-', '<cmd>vertical resize -5<CR>', { desc = 'Decrease window width' })
