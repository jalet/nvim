return {
  {
    'folke/tokyonight.nvim',
    enable = false,
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = 'transparent',
      },
    },
    config = function()
      vim.cmd.colorscheme 'tokyonight-storm'
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'gruvbox'
    end,
    opts = {
      transparent_mode = true,
    },
  },
}
