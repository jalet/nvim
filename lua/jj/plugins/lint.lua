local fever_root = os.getenv 'HOME' .. '/projects/fever.energy/fever-api'

return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = {
        dockerfile = { 'hadolint' },
        json = { 'jsonlint' },
        markdown = { 'markdownlint' },
        terraform = { 'tflint' },
        yaml = { 'yamllint' },
        go = { 'fever_go' },
      }

      lint.linters.fever_go = {
        cmd = fever_root .. '/.sage/bin/golangci-lint',
        stdin = false,
        args = {
          'run',
          '--out-format',
          'json',
          '--config',
          fever_root .. '/.golangci.yml',
          '--concurrency',
          '3',
          '$FILENAME',
        },
        stream = 'stdout',
        ignore_exitcode = true,
        parser = require('lint.parser').from_errorformat('', {}),
      }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
