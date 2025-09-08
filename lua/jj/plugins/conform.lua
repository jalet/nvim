-- Because gci and gofumpt -w both write directly to disk, Neovim’s buffer
-- doesn’t auto-sync. To handle that gracefully, add this autocmd:
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.go',
  callback = function(args)
    local fever_root = vim.fn.expand '$HOME/projects/fever.energy'
    if args.file:sub(1, #fever_root) == fever_root then
      vim.cmd 'checktime' -- Reload buffer if changed externally
    end
  end,
})

return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
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
    },
  },
}
