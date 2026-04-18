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

vim.keymap.set('n', '<leader>o', '<CMD>Oil<CR>', { desc = 'Open Oil file explorer' })

require('oil').setup {
  default_file_explorer = true,
  columns = {
    'permissions',
    'icon',
  },
  view_options = {
    is_hidden_file = function(name, _)
      if contains(hidden_files, name) then
        return true
      end
      return false
    end,
  },
}
