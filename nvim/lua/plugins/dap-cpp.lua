return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')

      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.fn.stdpath('data')
          .. '/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
      }

      dap.configurations.cpp = {
        {
          name = 'Launch file',
          type = 'cppdbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = false,
          setupCommands = {
            {
              text = '-enable-pretty-printing',
              description = 'Enable GDB pretty printing',
              ignoreFailures = false,
            },
          },
        },
      }

      local dapui = require('dapui')

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- Reuse for C and Rust
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
}
