syntax on

set guicursor=
set noshowmatch
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set clipboard=unnamedplus

" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

let mapleader = " "

call plug#begin('~/.config/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'numToStr/Comment.nvim'
Plug 'preservim/nerdtree'
" Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

lua require("airborn")

colorscheme dracula
set background=dark
set t_Co=256

" NerdTree
nnoremap <leader>b :NERDTreeToggle<CR>

lua << EOF
require('Comment').setup()
EOF

" Telescope
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <leader>gst :Telescope git_status<CR>
nnoremap <leader>df :lua require("airborn.telescope").search_dotfiles()<CR>
nnoremap <leader>mdf :lua require("airborn.telescope").mdf()<CR>
nnoremap <leader>F :lua require("airborn.telescope").fuzzy_project_search()<CR>
nnoremap <C-f> :Telescope current_buffer_fuzzy_find<CR>

" LSP "
lua << EOF
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
-- on Windows
-- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"
