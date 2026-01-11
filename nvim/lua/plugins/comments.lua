return {
  {
    'numToStr/Comment.nvim',
    -- Lazy‑load when editing buffers (optional)
    event = 'VeryLazy',
    opts = {
      -- You can override default mappings here if you want
      toggler = {
        line = 'gcc', -- toggle line comment
        block = 'gbc', -- toggle block comment
      },
      opleader = {
        line = 'gc', -- operator comment (motions)
        block = 'gb', -- operator block comment
      },
    },
  },
}
