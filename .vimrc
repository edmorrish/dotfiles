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
set foldmethod=indent
let javaScript_fold=1
set spelllang=en_gb
set rnu

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Plug 'dense-analysis/ale'
Plug 'JulesWang/css.vim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'tpope/vim-fugitive'
" Plug 'Quramy/tsuquyomi'
Plug 'morhetz/gruvbox'
Plug 'takac/vim-hardtime'
Plug 'tpope/vim-repeat'
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
Plug 'easymotion/vim-easymotion'
Plug 'frazrepo/vim-rainbow'
Plug 'haya14busa/incsearch.vim'
"Plug 'psliwka/vim-smoothie'

if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"  Plug 'Shougo/vimproc.vim', { 'do': 'make' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" Plug 'ternjs/tern_for_vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-test/vim-test'


call plug#end()

function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction


" " For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

if has('nvim') 
  tnoremap <Esc> <C-\><C-n>
endif

let g:vim_json_conceal=0
let g:markdown_syntax_conceal=0


let mapleader=","
nnoremap <leader>sp :source $MYVIMRC<cr>:PlugInstall<cr>
nnoremap <leader>su :source $MYVIMRC<cr>:PlugUpdate<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>sz :!source ~/.zshrc && zgen reset<cr>
nnoremap <leader>ev :vs ~/.vimrc<cr>
nnoremap <leader>ez :vs ~/.zshrc<cr>

" Test
let g:test#basic#start_normal = 1
let g:test#neovim = 1
let test#strategy = "neovim"

nmap <silent> <leader>tn :TestNearest<cr>
nmap <silent> <leader>tf :TestFile<cr>
nmap <silent> <leader>ts :TestSuite<cr>
 
" CoC
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=number
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-css']

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gb :<C-u>CocCommand tsserver.findAllFileReferences<cr>
nmap <leader>ca <Plug>(coc-codeaction)
nmap <leader>cn <Plug>(coc-rename)

" spelling
nnoremap <leader>ft :set spell!<cr>
nnoremap <leader>ff 1z=
" space open/closes folds
nnoremap <space> za

nnoremap <leader>f :<C-u>FZF<cr>
nnoremap <leader>d :<C-u>GFiles<cr>

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
let g:ale_linters = {
\   'javascript': [
\       'eslint',
\   ],
\   'typescript': [
\       'eslint',
\       'prettier',
\   ],
\}
  
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
      \   'right': [[ 'cocstatus' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'coc#status'
      \ },
      \ }

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

nmap <leader>td :call CocActionAsync('doHover')<cr>



" undodir
set undofile
set undodir=~/.vim/undodir

let g:hardtime_default_on = 0
" 
" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1

" Remember last spot
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]
