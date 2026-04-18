require('mason').setup {}

require('mason-tool-installer').setup {
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
}
