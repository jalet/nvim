return {
  cmd = { 'helm_ls', 'serve' },
  filetypes = { 'helm' },
  root_markers = { 'Chart.yaml', 'Chart.lock' },
  settings = {
    ['helm-ls'] = {
      valuesFiles = {
        mainValuesFile = 'values.yaml',
        lintOverlayValuesFile = 'values.lint.yaml',
        additionalValuesFilesGlobPattern = 'values*.yaml',
      },
      yamlls = {
        enabled = true,
        path = 'yaml-language-server',
        config = {
          schemas = {
            kubernetes = 'templates/**',
          },
          completion = true,
          hover = true,
        },
      },
    },
  },
}
