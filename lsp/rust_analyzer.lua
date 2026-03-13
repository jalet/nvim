return {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', '.git' },
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        command = 'clippy',
      },
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        chainingHints = { enable = true },
        closingBraceHints = { enable = true },
        parameterHints = { enable = true },
        typeHints = { enable = true },
      },
    },
  },
}
