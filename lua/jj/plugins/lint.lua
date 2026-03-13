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
        terraform = { 'tflint' },
        yaml = { 'yamllint' },
      }

      lint.linters.yamllint.args = {
        '-c',
        os.getenv 'HOME' .. '/.config/yamllint/config',
        '--format',
        'parsable',
        '-',
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
