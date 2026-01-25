return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      {
        '<F5>',
        function()
          require('dap').continue()
        end,
        desc = 'DAP Continue',
      },
      {
        '<F10>',
        function()
          require('dap').step_over()
        end,
        desc = 'DAP Step Over',
      },
      {
        '<F11>',
        function()
          require('dap').step_into()
        end,
        desc = 'DAP Step Into',
      },
      {
        '<F12>',
        function()
          require('dap').step_out()
        end,
        desc = 'DAP Step Out',
      },
      {
        '<leader>b',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle Breakpoint',
      },
      {
        '<leader>B',
        function()
          require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
        desc = 'Conditional Breakpoint',
      },
      {
        '<leader>dr',
        function()
          require('dap').repl.open()
        end,
        desc = 'DAP REPL',
      },
      {
        '<leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = 'DAP Run Last',
      },
    },
  },
}
