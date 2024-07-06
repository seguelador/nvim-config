call plug#begin('~/.vim/plugged')

" Coc vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'github/copilot.vim'

" Plug 'nvim-lua/completion-nvim'
Plug 'glepnir/lspsaga.nvim'
" Plug 'tjdevries/nlua.nvim'
" Plug 'tjdevries/lsp_extensions.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Debugger
Plug 'mfussenegger/nvim-dap'

" Others
Plug 'darrikonn/vim-gofmt', { 'do': ':GoUpdateBinaries' }
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'
Plug 'stevearc/conform.nvim' " code formatter
Plug 'editorconfig/editorconfig-vim' " editorconfig.org

" Color schema
Plug 'gruvbox-community/gruvbox'

" For fun
" Cellular Automation animation
Plug 'eandrju/cellular-automaton.nvim'


call plug#end()


" Basics
let mapleader = " "

" Yank current selection into system clipboard
vmap <C-c> "*y
" Yank current line into system clipboard (if nothing is selected)
nmap <C-c> "*Y
" Paste from system clipboard
nmap <C-v> "*p

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>fml :CellularAutomaton make_it_rain<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup THE_PRIMEAGEN
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

lua << EOF
-- Setup treesitter
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- Enable TreeSitter syntax highlighting
  },
  incremental_selection = {
    enable = true, -- Enable incremental selection (expand/shrink selections based on syntax nodes)
  },
  textobjects = {
    enable = true, -- Enable TreeSitter textobjects (select, move, swap, etc. based on syntax)
  },
}

-- Setup conform
require("conform").setup({
    formatters_by_ft = {
        typescript = { "prettierd" },
        python = { "black" },
        javascript = { "prettierd" },
        go = { "gofmt" },
        java = { "google_java_format" }
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true
    },
})

local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python';
  args = { '-m', 'debugpy.adapter' };
}

EOF

