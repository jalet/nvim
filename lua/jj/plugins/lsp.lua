return {
  {
    'williamboman/mason.nvim',
    opts = {},
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      ensure_installed = {
        -- LSP servers
        'gopls',
        'pyright',
        'ruff',
        'rust-analyzer',
        'typescript-language-server',
        'lua-language-server',
        'nil',
        'biome',
        'terraform-ls',
        'yaml-language-server',
        'helm-ls',
        'docker-language-server',
        'docker-compose-language-service',
        'regols',
        'lemminx',
        'json-lsp',

        -- Formatters
        'stylua',
        'gci',
        'gofumpt',
        'prettierd',
        'alejandra',

        -- Linters
        'hadolint',
        'jsonlint',
        'tflint',
        'tfsec',
        'markdownlint',
        'yamllint',

        -- Debug adapters
        'delve',
      },
    },
  },

  { 'j-hui/fidget.nvim', opts = {} },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

}
