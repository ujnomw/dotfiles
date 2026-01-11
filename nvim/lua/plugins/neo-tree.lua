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
      source_selector = {
        winbar = true, -- toggle to show selector on winbar
        statusline = false, -- toggle to show selector on statusline
        show_scrolled_off_parent_node = false, -- boolean
        sources = { -- table
          {
            source = 'filesystem', -- string
            display_name = ' 󰉓 Files ', -- string | nil
          },
          -- {
          --   source = 'buffers', -- string
          --   display_name = ' 󰈚 Buffers ', -- string | nil
          -- },
          {
            source = 'git_status', -- string
            display_name = ' 󰊢 Git ', -- string | nil
          },
        },
        content_layout = 'start', -- string
        tabs_layout = 'equal', -- string
        truncation_character = '…', -- string
        tabs_min_width = nil, -- int | nil
        tabs_max_width = nil, -- int | nil
        padding = 0, -- int | { left: int, right: int }
        separator = { left = '▏', right = '▕' }, -- string | { left: string, right: string, override: string | nil }
        separator_active = nil, -- string | { left: string, right: string, override: string | nil } | nil
        show_separator_on_edge = false, -- boolean
        highlight_tab = 'NeoTreeTabInactive', -- string
        highlight_tab_active = 'NeoTreeTabActive', -- string
        highlight_background = 'NeoTreeTabInactive', -- string
        highlight_separator = 'NeoTreeTabSeparatorInactive', -- string
        highlight_separator_active = 'NeoTreeTabSeparatorActive', -- string
      },
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
        filtered_items = {
          visible = true,
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

    -- Git
    vim.keymap.set('n', '<leader>g', '<cmd>Neotree reveal git_status<CR>')
  end,
}
