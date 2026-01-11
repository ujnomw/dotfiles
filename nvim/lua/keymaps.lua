local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ======================
-- Insert mode
-- ======================

-- jk to escape insert mode
keymap("i", "jk", "<Esc>", opts)

-- ======================
-- Normal mode leader mappings
-- ======================

-- Save file
keymap("n", "<leader>w", ":write<CR>", opts)

-- Close current buffer
keymap("n", "<leader>q", ":bdelete<CR>", opts)


-- Project-wide search (vimgrep / ripgrep)
keymap("n", "<leader>f", ":vimgrep // **/*<Left><Left><Left>", opts)

-- Git status (fugitive)
keymap("n", "<leader>g", ":Git<CR>", opts)

-- Toggle terminal
keymap("n", "<leader>t", ":terminal<CR>", opts)

-- Quick file open in current directory
keymap(
  "n",
  "<leader>p",
  ':edit <C-R>=expand("%:h") . "/"<CR>',
  opts
)


-- ======================
-- Window navigation
-- ======================

keymap("n", "H", "<C-w>h", opts)
keymap("n", "L", "<C-w>l", opts)
keymap("n", "K", "<C-w>k", opts)
keymap("n", "J", "<C-w>j", opts)

-- Split window right
keymap("n", "<leader>s", ":vsplit<CR>", opts)

-- Focus sidebar (netrw)
keymap("n", "<leader>0", ":Lexplore<CR>", opts)

-- Focus editor groups by window number
keymap("n", "<leader>1", ":1wincmd w<CR>", opts)
keymap("n", "<leader>2", ":2wincmd w<CR>", opts)
keymap("n", "<leader>3", ":3wincmd w<CR>", opts)

-- ======================
-- Buffers
-- ======================

-- Previous buffer
keymap("n", "<leader>n", ":bprevious<CR>", opts)

-- Least recently used buffer (last)
keymap("n", "<leader>N", ":blast<CR>", opts)

-- Resize splits with Ctrl + arrow keys

local function resize_left()
  if vim.api.nvim_win_get_position(0)[2] == 0 then
    vim.cmd('vertical resize -2')  -- left window
  else
    vim.cmd('vertical resize +2')  -- right window
  end
end

local function resize_right()
  if vim.api.nvim_win_get_position(0)[2] == 0 then
    vim.cmd('vertical resize +2')  -- left window
  else
    vim.cmd('vertical resize -2')  -- right window
  end
end

vim.keymap.set('n', '<A-Left>', resize_left)
vim.keymap.set('n', '<A-Right>', resize_right)
vim.keymap.set('n', '<A-Up>',    function() vim.cmd('resize +2') end)
vim.keymap.set('n', '<A-Down>',  function() vim.cmd('resize -2') end)

