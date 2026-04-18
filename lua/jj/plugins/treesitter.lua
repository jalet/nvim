-- nvim-treesitter `main` branch (Neovim 0.12+): the plugin only installs
-- parsers and exposes an indentexpr. Highlighting is wired up per-buffer via
-- vim.treesitter.start() on FileType.

local parsers = {
  'bash',
  'c',
  'go',
  'html',
  'java',
  'javascript',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'nix',
  'regex',
  'rust',
  'terraform',
  'vim',
  'vimdoc',
}

local installed = require('nvim-treesitter.config').get_installed()
local missing = vim.iter(parsers)
  :filter(function(p)
    return not vim.tbl_contains(installed, p)
  end)
  :totable()
if #missing > 0 then
  require('nvim-treesitter').install(missing)
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('jj-treesitter', { clear = true }),
  callback = function(ev)
    if not pcall(vim.treesitter.start, ev.buf) then
      return
    end
    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
