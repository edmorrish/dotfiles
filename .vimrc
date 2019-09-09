syntax enable
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set number
set showcmd
filetype indent on
filetype plugin on
set lazyredraw
set showmatch

set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldcolumn=1
set foldmethod=syntax
let javaScript_fold=1
set spelllang=en_gb
set rnu

call plug#begin('~/.vim/plugged')

Plug 'sjl/badwolf'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'dense-analysis/ale'
Plug ''.expand('~/workdir/repos/vim-svelte/')
Plug 'JulesWang/css.vim'
Plug 'leafgarland/typescript-vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'derekwyatt/vim-scala'
Plug 'tpope/vim-fugitive'
Plug 'Quramy/tsuquyomi'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim',{'as':'dracula'}
Plug 'takac/vim-hardtime'
Plug 'tpope/vim-repeat'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'ternjs/tern_for_vim'
call plug#end()

function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
let g:deoplete#sources#ternjs#tern_bin = $HOME . '/workdir/repos/tern/bin/tern'
call deoplete#custom#source('tern', 'rank', 1000)
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#case_insensitive = 1
set completeopt-=preview

" tern
let g:tern#command = [$HOME . '/workdir/repos/tern/bin/tern']
let g:tern#arguments = ["--persistent"]
nnoremap <leader>td :TernDef<CR>

let mapleader=","
nnoremap <leader>sp :source $MYVIMRC<cr>:PlugInstall<cr>
nnoremap <leader>su :source $MYVIMRC<cr>:PlugUpdate<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>sz :!source ~/.zshrc && zgen reset<cr>
nnoremap <leader>ev :vs ~/.vimrc<cr>
nnoremap <leader>ez :vs ~/.zshrc<cr>

" LanguageClient
let g:LanguageClient_serverCommands = {
      \ 'reason': [$HOME . '/bin/reason-language-server'],
      \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

" spelling
nnoremap <leader>ft :set spell!<cr>
nnoremap <leader>ff 1z=
" space open/closes folds
"nnoremap <space> za

"crtlp
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_map='<c-=>'
nnoremap <leader>p :CtrlP<cr>

" ALE
let g:ale_fixers = {
\   'javascript': [
\       'eslint',
\   ],
\   'typescript': [
\       'eslint',
\   ],
\}
autocmd FileType typescript let g:ale_javascript_eslint_options = '--ext ts,tsx,js,jsx'
  
let g:ale_fix_on_save = 1

" Tsuquyomi
autocmd FileType typescript nmap <buffer> <Leader>th : <C-u>echo tsuquyomi#hint()<CR>


" Gruvbox
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'

" Lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'component_expand': {
      \   'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \   },
      \ 'component_type': {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
      \ }

let g:hardtime_default_on = 1
