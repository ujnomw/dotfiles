return {
  {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup()

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {
      handlers = {},
    },
    ensure_installed = {
      'codelldb',
      'cppdbg', -- 👈 GDB support
    },
  },

  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')

      -- GDB adapter (cppdbg)
      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.fn.stdpath('data') .. '/mason/bin/OpenDebugAD7',
        options = {
          detached = false,
        },
      }

      -- GDB launch config
      dap.configurations.cpp = {
        {
          name = 'Launch (gdb)',
          type = 'cppdbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = false,
          MIMode = 'gdb',
          miDebuggerPath = '/usr/bin/gdb',
          setupCommands = {
            {
              description = 'Enable pretty printing',
              text = '-enable-pretty-printing',
              ignoreFailures = true,
            },
          },
        },
        {
          name = 'Attach (gdb)',
          type = 'cppdbg',
          request = 'attach',
          processId = require('dap.utils').pick_process,
          MIMode = 'gdb',
          miDebuggerPath = '/usr/bin/gdb',
        },
      }

      -- dap.configurations.c = dap.configurations.cpp
    end,
  },
}
