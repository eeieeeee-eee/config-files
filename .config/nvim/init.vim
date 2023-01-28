noremap 0 ^
noremap ^ 0
lua require ('init')
""""""""""""""""
"Vim-Plug
call plug#begin()

Plug 'ycm-core/YouCompleteMe'
Plug 'dracula/vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'yegappan/mru'
Plug 'preservim/nerdtree'
Plug 'chr4/nginx.vim'
Plug 'rust-lang/rust.vim'
Plug 'godlygeek/tabular'
Plug 'vim-airline/vim-airline'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'farmergreg/vim-lastplace'
Plug 'wesQ3/vim-windowswap'
Plug 'preservim/tagbar'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'sirtaj/vim-openscad'

call plug#end()
syntax enable
filetype plugin indent on

""""""""""""""""
"Options

set nobackup
set nowb
set noswapfile
set undodir=~/.config/nvim/tmp/undo
set undofile
set history=500
set autoread
set wildmenu
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set ruler
au FocusGained,BufEnter * checktime
set ignorecase
set so=5
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set ai
set si 
set wrap
set noshowmode
let MRU_Max_Entries = 400
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=30
let g:ctrlp_working_path_mode = 0
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set completeopt-=preview
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
let g:ale_linters = {'asm':[]}

colorscheme dracula

""""""""""""""""
"Remap keys
map i <Up>
map j <Left>
map k <Down>
map l <Right>
map h <insert>

""""""""""""""""
"Commands
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

""""""""""""""""
"Mappings

let mapleader = ','

nmap <leader>fw <esc><Plug>(YCMFindSymbolInWorkspace)
nmap <leader>fd <esc>:YcmCompleter GoToDeclaration<cr>
nmap <leader>fu <esc>:MRU<CR>
let g:ctrlp_map = '<C-f>'
nmap <leader>ff <esc>:CtrlP<cr>
nmap <leader>fb <esc>:CtrlPBuffer<cr>
nmap <leader>fl <esc>:Lines<cr>
nmap <leader>nn <esc>:NERDTreeToggle<cr>
nmap <leader>nf <esc>:NERDTreeFind<cr>
nmap <leader>nt <esc>:TagbarToggle<cr>
nmap <leader>nd <esc>:YcmCompleter GetDoc<cr>
nmap <C-c> <esc>:qa<cr>

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

map <Leader>rm <ESC>:exec &mouse!=""? "set mouse=" : "set mouse=a"<CR>
map <Leader>rp <ESC>:set invpaste paste?<CR>
let g:windowswap_map_keys = 0
nnoremap <silent> <leader>yy :call WindowSwap#EasyWindowSwap()<CR>

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext
nmap <leader>w :w!<cr>

vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

noremap 0 ^
noremap ^ 0

map <leader>ss :setlocal spell!<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

""""""""""""""""
"Filetype preferences

autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab

au FileType python syn keyword pythonDecorator True None False self

""""""""""""""""
"Compile with F5
map <F5> :call CompileRun()<CR>
imap <F5> <Esc>:call CompileRun()<CR>
vmap <F5> <Esc>:call CompileRun()<CR>
map <Leader>rr :call CompileRun()<CR>

func! CompileRun()
    exec "w"
    if &filetype == 'tex'
        exec "!latexmkk"
    endif
endfunc

""""""""""""""""
"Other functions

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""
"Kitty Background

if &term == 'xterm-kitty'
    let &t_ut=''
endif
