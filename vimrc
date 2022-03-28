" Maintainer: : Tim Taylor	
" Last change: Sat Dec 18 12:24:26 MST 2021

" Automatically downloads vim-plug manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'bfrg/vim-cpp-modern'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'dense-analysis/ale'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-tsserver']

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" begin CoC settings
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
"set signcolumn=yes

" Trigger completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" CoC mappings
nmap <buffer> <leader>gd <Plug>(coc-definition)
nmap <buffer> <leader>gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" end CoC

" Sync syntax highlighting on large files for js and ts
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  "set hlsearch
endif

filetype plugin on

" because lightline plug shows your status:
set noshowmode

set shiftwidth=2
set softtabstop=2
set expandtab

" Press ctrl-n twice to turn numbers on and off
nmap <C-N><C-N> :set invnumber<CR>

" ctrl-e to move through ale errors
nmap <silent> <C-e> <Plug>(ale_next_wrap)
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

" Adds a new line at the end of files, so you don't have to
set eol

" autosave rust format
let g:rustfmt_autosave = 1
