call plug#begin('~/.config/nvim/autoload/plugged')
Plug 'tpope/vim-sensible'
Plug 'itchyny/lightline.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'terrortylor/nvim-comment'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'windwp/nvim-autopairs'
Plug 'lervag/vimtex'
" run snippets of code :SnipRun
Plug 'michaelb/sniprun', {'do': 'sh install.sh'}
" neorg and Org-mode for neovim \oe to export org to pdf via latex
Plug 'nvim-orgmode/orgmode'
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'akinsho/org-bullets.nvim'
" Snippets and Completion
Plug 'L3MON4D3/LuaSnip' 
Plug 'hrsh7th/nvim-cmp'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
" Neovim File Explorer
Plug 'nvim-tree/nvim-tree.lua'
Plug 'kelly-lin/ranger.nvim'
" Floating nvim ranger
Plug 'kevinhwang91/rnvimr'
" from markdown to latex
Plug 'abeleinin/papyrus'
" show function signature
Plug 'ray-x/lsp_signature.nvim'
call plug#end()
