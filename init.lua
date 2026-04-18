-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.editorconfig = true

-- Set early so plugin specs and setup functions can read it (plugin/options.lua
-- is sourced after init.lua, so mirror the value here).
vim.g.have_nerd_font = true

if vim.fn.has 'nvim-0.12' == 0 then
  vim.notify('This config requires Neovim 0.12+ (vim.pack)', vim.log.levels.ERROR)
  return
end

-- Highlight when yanking (copying) text. Try it with `yap` in normal mode.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

require 'jj.plugins'
