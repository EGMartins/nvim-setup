" ===========
" Plugins
" ===========
call plug#begin('~/.vim/plugged')
" Collection of color schemes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'ap/vim-buftabline'
Plug 'roman/golden-ratio' " Auto-expands current split
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rails'
Plug 'alvan/vim-closetag'
Plug 'valloric/MatchTagAlways'
Plug 'machakann/vim-sandwich'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'dense-analysis/ale'
Plug 'itmammoth/run-rspec.vim'
Plug 'tpope/vim-rails'
Plug 'ngmy/vim-rubocop'
Plug 'vim-airline/vim-airline'
Plug 'elixir-editors/vim-elixir'
Plug 'mattn/emmet-vim'
Plug 'dense-analysis/ale'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
" Use the colorscheme
colorscheme PaperColor

" configurações básicas {{{
set nocompatible  " não precisamos ser totalmente compatíveis com o Vi!
syntax on         " habilita syntax highlight
let mapleader=" "
let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.tsx'
set history=1000
" }}}

"  scrolling {{{
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
" }}}

" backup {{{
set nobackup      " não mantém arquivos .swp
set writebackup   " cria um arquivo de backup quando sobrescreve
" }}}

set background=dark

set number relativenumber      " número relativo da linha, salva a pátria!
set novisualbell        " sem ficar piscando, enche o saco
set smartindent         " indenta linhas novas
set foldmethod=indent   " método de fold (dobras) baseado em indentação
set ignorecase          " ignora maiúsculas e minúsculas
set hlsearch            " destaca os termos de pesquisa que foram encontrados
set incsearch           " mostra o termo de pesquisa enquanto ele é digitado
set laststatus=2        " sempre usar linhas de status
set textwidth=80        " comprimento máximo do texto inserido antes de quebrar a linha
set cursorline          " destaca a linha que o cursor está
set showmatch           " mostra os parenteses que 'casam'
highlight ColorColumn ctermbg=DarkGrey
set colorcolumn=120

" tabs default {{{
set tabstop=2           " número de espaços da tabulação
set softtabstop=2     	" número de espaços de tabulação para edição
set shiftwidth=2        	" número de espaços para usar com a indentação automática
set expandtab          	" fim da guerra: use espaços ao invés de tabulações
" }}}

set clipboard^=unnamedplus " Use the system register
set hidden

:imap jk <Esc>

let g:run_rspec_bin = 'bundle exec rspec'
" RSpec vim mappings
nnoremap <leader>t :RunSpec<CR>
nnoremap <leader>s :RunSpecLine<CR>
nnoremap <leader>e :RunSpecLastRun<CR>
nnoremap <leader>cr :RunSpecCloseResult<CR>

nnoremap <CR> :noh
nnoremap <C-O> :bnext<CR>
nnoremap <C-P> :bprev<CR>
" Navigate tabs
nnoremap <C-j> :tabnext<CR>
nnoremap <C-k> :tabprev<CR>

" FUGITIVE remaps
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>

" Set Gdiff to split vertically as default behavior
set diffopt+=vertical
" Fugitive Conflict Resolution
nnoremap <leader>gd :Gdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" SPLITS
set splitbelow " open a new vertical split below
set splitright " open a new horizontal split on the right
set fillchars=vert:│ " Vertical separator between windows"
" Navigate splits
nnoremap <C-h> <C-w>h " Ctrl + h to move to the left split
nnoremap <C-l> <C-w>l " Ctrl + l to move to the right one
let NERDTreeQuitOnOpen=1 " Close the NERDTree after opening a file
nnoremap nt :NERDTreeToggle<CR>
nnoremap nf :NERDTreeFind<CR>
map <F5> gg=G`a
let g:mta_filetypes = {
\ 'html' : 1,
\ 'typescriptreact': 1,
\}
"let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 1
nnoremap ]r :ALENextWrap<CR> " move to the next ALE warning / error

nnoremap [r :ALEPreviousWrap<CR> " move to the previous ALE warning / erro
nnoremap <leader>d :ALEDetail<cr> " show the full message
" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
set statusline+=%=
set statusline+=\ %{LinterStatus()}

let g:fzf_action = {
\ 'enter': 'tab split',
\ 'ctrl-x': 'split',
\ 'ctrl-v': 'vsplit' }

" Limit the window size to 40% screen from the bottom
let g:fzf_layout = { 'down': '~40%' }
" Mapping for most oftenly used command
nnoremap <Leader><Leader> :Files<cr>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


