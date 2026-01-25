return {
  -- Core DAP
  {
    'mfussenegger/nvim-dap',
  },

  -- UI for DAP
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      require('dapui').setup()
    end,
  },

  -- Virtual text (inline variable values)
  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = true,
  },

  -- Mason integration (important)
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
      'mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {
      ensure_installed = {},
      automatic_installation = false,
    },
  },
}
