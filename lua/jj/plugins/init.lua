-- Plugin management via Neovim 0.12's native `vim.pack`.
--
-- Flow:
--   1. Register PackChanged autocmd so build hooks fire on first install.
--   2. vim.pack.add {...} clones and activates every plugin.
--   3. require each config module to run its setup().

local gh = function(repo)
  return 'https://github.com/' .. repo
end

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('jj-pack-build', { clear = true }),
  callback = function(ev)
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then
      return
    end
    local name = ev.data.spec.name
    if name == 'telescope-fzf-native.nvim' then
      vim.system({ 'make' }, { cwd = ev.data.path }):wait()
    end
    -- nvim-treesitter on `main` branch installs parsers at runtime via
    -- require('nvim-treesitter').install(...) in its config module, so no
    -- PackChanged hook is needed.
  end,
})

local specs = {
  -- Core libraries (loaded first as transitive deps).
  { src = gh 'nvim-lua/plenary.nvim' },
  { src = gh 'MunifTanjim/nui.nvim' },
  { src = gh 'folke/snacks.nvim' },

  -- UI loaded early so later errors render in the intended style.
  { src = gh 'ellisonleao/gruvbox.nvim' },
  { src = gh 'folke/noice.nvim' },

  -- Mason before anything that registers with it.
  { src = gh 'williamboman/mason.nvim' },
  { src = gh 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = gh 'jay-babu/mason-nvim-dap.nvim' },

  -- Editor UX.
  { src = gh 'tpope/vim-sleuth' },
  { src = gh 'tpope/vim-fugitive' },
  { src = gh 'lewis6991/gitsigns.nvim' },
  { src = gh 'stevearc/oil.nvim' },
  { src = gh 'echasnovski/mini.nvim' },
  { src = gh 'lukas-reineke/indent-blankline.nvim' },
  { src = gh 'laytan/cloak.nvim' },
  { src = gh 'folke/todo-comments.nvim' },

  -- Treesitter + telescope stack.
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = gh 'nvim-tree/nvim-web-devicons' },
  { src = gh 'nvim-telescope/telescope.nvim', version = '0.1.x' },
  { src = gh 'nvim-telescope/telescope-ui-select.nvim' },
}

if vim.fn.executable 'make' == 1 then
  table.insert(specs, { src = gh 'nvim-telescope/telescope-fzf-native.nvim' })
end

vim.list_extend(specs, {
  -- Formatting + linting.
  { src = gh 'stevearc/conform.nvim' },
  { src = gh 'mfussenegger/nvim-lint' },

  -- LSP + completion.
  { src = gh 'j-hui/fidget.nvim' },
  { src = gh 'folke/lazydev.nvim' },
  { src = gh 'rafamadriz/friendly-snippets' },
  { src = gh 'saghen/blink.cmp', version = vim.version.range '1' },

  -- Debug adapter protocol.
  { src = gh 'mfussenegger/nvim-dap' },
  { src = gh 'rcarriga/nvim-dap-ui' },
  { src = gh 'nvim-neotest/nvim-nio' },
  { src = gh 'leoluz/nvim-dap-go' },

  -- Filetype plugins.
  { src = gh 'grafana/vim-alloy' },

  -- AI assistant.
  { src = gh 'greggh/claude-code.nvim' },
})

-- load = true: add plugins to rtp immediately so require() works below.
-- Default during init.lua is load = false, which defers plugin/ sourcing but
-- also leaves the opt/ dirs off rtp until Neovim's post-init scan.
vim.pack.add(specs, { confirm = false, load = true })

-- Configure each plugin. Order matters: mason must be set up before
-- mason-tool-installer enqueues tools, and blink.cmp's setup enables LSP
-- servers so it runs after mason is ready.
require 'jj.plugins.colorscheme'
require 'jj.plugins.noice'
require 'jj.plugins.mason'
require 'jj.plugins.gitsigns'
require 'jj.plugins.oil'
require 'jj.plugins.mini'
require 'jj.plugins.indent_line'
require 'jj.plugins.cloak'
require 'jj.plugins.comments'
require 'jj.plugins.treesitter'
require 'jj.plugins.telescope'
require 'jj.plugins.conform'
require 'jj.plugins.lint'
require 'jj.plugins.fidget'
require 'jj.plugins.lazydev'
require 'jj.plugins.blink-cmp'
require 'jj.plugins.debug'
require 'jj.plugins.claude-code'
