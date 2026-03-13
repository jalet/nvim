return {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'terraform-vars', 'hcl' },
  root_markers = { '.terraform', '.git' },
  settings = {
    ['terraform-ls'] = {
      experimentalFeatures = {
        prefillRequiredFields = true,
      },
    },
  },
}
