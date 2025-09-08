return {
  'folke/noice.nvim',
  dependencies = {
    'folke/snacks.nvim',
  },
  lazy = false,
  priority = 1000,
  opts = {
    lsp = {
      progress = {
        enabled = false,
      },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },
    presets = {
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
}
