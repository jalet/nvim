return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose' },
  root_markers = { '.git' },
  settings = {
    yaml = {
      format = {
        enable = true,
        singleQuote = true,
      },
      schemastore = {
        enable = true,
      },
      schemas = {
        ['https://json.schemastore.org/github-workflow'] = '.github/workflows/*.{yml,yaml}',
        ['https://json.schemastore.org/github-action'] = '.github/action/*.{yml,yaml}',
      },
    },
  },
}
