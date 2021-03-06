call plug#begin('~/.vim/plugged')

" Fuzzy Find
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Version Control
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'airblade/vim-gitgutter'

" Multiple Visual Cursors
Plug 'terryma/vim-multiple-cursors'

" TOML Syntax Highlighting
Plug 'cespare/vim-toml'

" Rust Plug
Plug 'rust-lang/rust.vim'

" Javascript Plug
Plug 'pangloss/vim-javascript'

" JSX Plug
Plug 'mxw/vim-jsx'

" Typescript Plug
Plug 'leafgarland/typescript-vim'

" Typescript JSX Plug
Plug 'peitalin/vim-jsx-typescript'

" Rainbow Parens
Plug 'luochen1990/rainbow'

" Scala Highlighting
Plug 'derekwyatt/vim-scala'

" OpenCL Highlighting
Plug 'petRUShka/vim-opencl'

" Required for ncm2
Plug 'roxma/nvim-yarp'

Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'LnL7/vim-nix'

call plug#end()

" Language Client Servers
let g:LanguageClient_serverCommands = {
\ 'rust': ['rust-analyzer'],
\ 'scala': ['metals-vim'],
\ 'python': ['pyls'],
\ 'javascript.jsx': ['javascript-typescript-stdio'],
\ 'typescript': ['javascript-typescript-stdio'],
\ 'c': ['clangd'],
\ 'cpp': ['clangd'],
\ }

let g:LanguageClient_hoverPreview = "Always"
let g:LanguageClient_useFloatingHover = 0

" Language Client Shortcuts
au FileType * nmap <leader><leader>t :call LanguageClient#textDocument_hover()<CR>
au FileType * nmap <leader><leader>d :call LanguageClient#textDocument_definition()<CR>

" use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

if filereadable(expand("~/.vim/plugged/ncm2/autoload/ncm2.vim"))
    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()
endif
set completeopt=noinsert,menuone,noselect

" Auto format rust code on save
let g:rustfmt_autosave = 1

" Disable preview window when using autocomplete
set completeopt-=preview

" Multiple Cursors
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_next_key = '<C-a>'
let g:multi_cursor_quit_key = '<Esc>'

" Enable rainbow parens
let g:rainbow_active = 1

" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

" Highlight comments in json
autocmd FileType json syntax match Comment +\/\/.\+$+

" GitGutter
if filereadable(expand("~/.vim/plugged/vim-gitgutter/autoload/gitgutter.vim"))
    highlight GitGutterAdd    ctermfg=2
    highlight GitGutterChange ctermfg=3
    highlight GitGutterDelete ctermfg=1
    autocmd BufWritePost * GitGutter
endif
