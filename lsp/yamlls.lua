return {
  settings = {
    yaml = {
      format = {
        enable = true,
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
