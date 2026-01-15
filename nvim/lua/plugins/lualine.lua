return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy', -- lazy-load on idle
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional icons
  config = function()
    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'tokyonight', -- pick your favorite theme
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'NvimTree', 'lazy' },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'quickfix', 'nvim-tree' },
    })
  end,
}
