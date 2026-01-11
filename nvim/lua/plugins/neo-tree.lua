return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons', -- optional, icons
  },
  lazy = false,
  config = function()
    -- local reference keeps everything encapsulated
    local neotree = require('neo-tree')

    neotree.setup({
      window = {
        position = 'left',
        width = 30,
        mappings = {
          ['<space>'] = { 'open', nowait = true }, -- instant vertical split
          ['<cr>'] = 'open', -- normal open
          ['s'] = 'open_split', -- horizontal split
          ['v'] = 'open_vsplit',
          ['t'] = 'open_tabnew',
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
      },
    })

    -- 🔑 Encapsulated keybinding
    vim.keymap.set(
      'n',
      '<leader>e',
      '<cmd>Neotree filesystem toggle left<CR>',
      { desc = 'Toggle Neo-tree' }
    )
  end,
}
