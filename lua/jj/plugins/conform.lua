-- gci and gofumpt -w both write directly to disk, so the buffer doesn't
-- auto-sync. Reload Go buffers under the fever.energy tree after save.
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.go',
  callback = function(args)
    local fever_root = vim.fn.expand '$HOME/projects/fever.energy'
    if args.file:sub(1, #fever_root) == fever_root then
      vim.cmd 'checktime'
    end
  end,
})

require('conform').setup {
  default_format_opts = {
    lsp_format = 'fallback',
  },
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
  formatters = {
    gci = { -- INFO: Fever Energy
      command = 'gci',
      args = {
        'write',
        '--skip-generated',
        '-s',
        'standard',
        '-s',
        'default',
        '$FILENAME',
      },
      stdin = false,
      env = {
        GOROOT = os.getenv 'GOROOT',
        GOPATH = os.getenv 'GOPATH',
        PATH = os.getenv 'PATH',
      },
    },
    gofumpt = { -- INFO: Fever Energy
      command = 'gofumpt',
      args = { '-w', '$FILENAME' },
      stdin = false,
    },
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    go = { 'gci', 'gofumpt' }, -- INFO: Fever Energy
    javascript = { 'prettierd' },
    typescript = { 'prettierd' },
  },
}

vim.keymap.set('', '<leader>f', function()
  require('conform').format { async = true, lsp_fallback = true }
end, { desc = '[F]ormat buffer' })
