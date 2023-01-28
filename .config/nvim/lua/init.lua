--Options
vim.cmd[[
let mapleader = ','

set number! relativenumber!
set numberwidth=2
set signcolumn=yes

set nobackup
set nowb
set noswapfile
set undodir=~/.local/share/nvim/undo
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
set foldmethod=manual

""Mapping
nnoremap <Space> za
vnoremap <Space> zf

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

map <Leader>rm <ESC>:exec &mouse!=""? "set mouse=" : "set mouse=a"<CR>
map <Leader>rp <ESC>:set invpaste paste?<CR>

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext
nmap <leader>w :w!<cr>

let g:lasttab = 1
nmap <silent> tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

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

""Filetype Prefs
au FileType nim setlocal ts=4 sts=4 sw=4 expandtab

""Commands
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
]]

--Plug Options
vim.cmd[[let g:coq_settings = { 'display.pum.fast_close': v:false, 'auto_start': 'shut-up' }]]
vim.cmd[[
let g:windowswap_map_keys = 0
nnoremap <silent> <leader>yy :call WindowSwap#EasyWindowSwap()<CR>
]]

require('plugins')

require("catppuccin").setup({
	flavor = "mocha",
	integrations = {
            treesitter = true
	}
})

require'nvim-lastplace'.setup{}

--Color
vim.cmd.colorscheme "catppuccin"
