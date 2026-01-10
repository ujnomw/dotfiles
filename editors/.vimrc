" === Basics ===

" Use system clipboard
set clipboard=unnamedplus

" Search behavior
set hlsearch
set incsearch

" Enable Ctrl keys (default in Vim, but explicit for clarity)
set nocompatible

" Leader key
let mapleader=" "

" === Insert mode ===

" jk to escape insert mode
inoremap jk <Esc>

" === Normal mode leader mappings ===

" Save file
nnoremap <leader>w :write<CR>

" Close current buffer
nnoremap <leader>q :bdelete<CR>

" File explorer (netrw)
nnoremap <leader>e :Explore<CR>

" Project-wide search (requires ripgrep)
nnoremap <leader>f :vimgrep // **/*<Left><Left><Left>

" Git status (requires fugitive.vim)
nnoremap <leader>g :Git<CR>

" Toggle terminal (Neovim)
nnoremap <leader>t :terminal<CR>

" Quick file open
nnoremap <leader>p :edit <C-R>=expand("%:h") . "/"<CR>

" Toggle file tree (netrw)
nnoremap <leader>b :Lexplore<CR>

" Window navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>k <C-w>k
nnoremap <leader>j <C-w>j

" Split window right
nnoremap <leader>s :vsplit<CR>

" Focus sidebar (netrw)
nnoremap <leader>0 :Lexplore<CR>

" Focus editor groups (window numbers)
nnoremap <leader>1 :1wincmd w<CR>
nnoremap <leader>2 :2wincmd w<CR>
nnoremap <leader>3 :3wincmd w<CR>

" Previous buffer
nnoremap <leader>n :bprevious<CR>

" Least recently used buffer
nnoremap <leader>N :blast<CR>

