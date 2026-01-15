return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- Hover doc popups (K)
        hover = {
          enabled = true,
        },
        -- Function signature popups
        signature = {
          enabled = true,
        },
        -- Override markdown rendering so LSP docs look good
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },

      -- Better cmdline popup (:/ ?/ etc)
      cmdline = {
        enabled = false,
      },

      -- Messages like "written", errors, search results
      messages = {
        enabled = true,
      },

      -- Floating window borders
      views = {
        hover = {
          border = {
            style = 'rounded',
          },
        },
        signature = {
          border = {
            style = 'rounded',
          },
        },
      },

      presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },

    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },
}
