local hidden_files = {
  '.DS_Store',
  '.gen',
  '.git',
  '.idea',
  '.vscode',
  'node_modules',
}

local function contains(xs, x)
  for _, v in ipairs(xs) do
    if v == x then
      return true
    end
  end
  return false
end

return {
  -- Oil
  {
    'stevearc/oil.nvim',
    config = function()
      vim.keymap.set('n', '<leader>o', '<CMD>Oil<CR>', { desc = 'Open Oil file explorer' })

      require('oil').setup {
        -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
        -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
        default_file_explorer = true,
        -- Id is automatically added at the beginning, and name at the end
        -- See :help oil-columns
        columns = {
          'permissions',
          'icon',
        },

        view_options = {
          is_hidden_file = function(name, bufnr)
            -- Hide files in the hidden_files table
            if contains(hidden_files, name) then
              return true
            end

            return false
          end,
        },
      }
    end,
  },
}
