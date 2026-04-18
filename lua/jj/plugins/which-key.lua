require('which-key').setup {
  preset = 'modern',
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { '<leader>s', group = '[S]earch' },
    { '<leader>d', group = '[D]ocument' },
    { '<leader>w', group = '[W]orkspace' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>c', group = '[C]ode' },
    { '<leader>r', group = '[R]ename' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  },
}
