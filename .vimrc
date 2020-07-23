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
set foldcolumn=0
set foldmethod=syntax
let javaScript_fold=1
set spelllang=en_gb
set rnu

call plug#begin('~/.vim/plugged')

Plug 'sjl/badwolf'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'dense-analysis/ale'
Plug ''.expand('~/workdir/repos/vim-svelte/')
Plug 'JulesWang/css.vim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
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
Plug 'chrisbra/Colorizer'
Plug 'haya14busa/incsearch.vim'
Plug 'easymotion/vim-easymotion'
Plug 'jparise/vim-graphql'
Plug 'dleonard0/pony-vim-syntax'
Plug 'jakwings/vim-pony'
Plug 'psliwka/vim-smoothie'


if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/vimproc.vim', { 'do': 'make' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'ternjs/tern_for_vim'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
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

" neosnippet
" " Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif


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
nnoremap <space> za

nnoremap <leader>d :<C-u>FZF<cr>

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

" Italics
highlight Comment cterm=italic


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

" undodir
set undofile
set undodir=~/.vim/undodir

let g:hardtime_default_on = 0

let g:colorizer_auto_filetype='css,html,scss'

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1


