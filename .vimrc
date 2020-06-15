" General {{{
set showcmd
" }}}

" Plugins {{{
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" NERDTree {{{
Plug 'preservim/nerdtree'

let NERDTreeShowHidden=1
" }}}
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-test/vim-test'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
call plug#end()
" }}}

" Colors {{{
syntax enable
autocmd vimenter * colorscheme gruvbox
let g:vruvbox_contrast_dark='hard'
" }}}

" Spaces & Tabs {{{
" https://www.cs.oberlin.edu/~kuperman/help/vim/indenting.html
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
" }}}

" UI Config {{{
set number " show line numbers
set cursorline " highlight current line
filetype indent on " use filetype-specific rules
                   " e.g. ~/.vim/indent/python.vim for *.py files
set wildmenu " visual autocomplete for the command menu
             " e.g. :e ~/.vim<TAB>
set lazyredraw " redraw only when needed
set showmatch " highlight matching [{()}]
set mouse=n
" https://www.simplified.guide/vim/auto-complete-javascript
" https://vi.stackexchange.com/a/13359
" }}}

" Searching {{{
set incsearch " search as characters are entered
set hlsearch " highlight matches
" turn off search highlighting
nnoremap <leader><space> :nohlsearch<CR>
" }}}

" Folding {{{
set foldenable
set foldlevelstart=10 " open a lot of folds
set foldnestmax=10 " folds can be nested
set foldmethod=indent
" }}}

" Movement {{{
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" highlight last inserted text
nnoremap gV `[v`]
" }}}

" Navigation {{{
let g:NERDTreeChDirMode = 2
" }}}

" Leader Shortcuts {{{
let mapleader=" "
" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" save session: saves the current windows for the next session
nnoremap <leader>s :mksession<CR>
" open ag.vim: all about the silver searcher
nnoremap <leader>a :Ag
nnoremap <leader>l :call <SID>ToggleNumber()<CR>
nnoremap <leader>t :TestFile<CR>
nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <leader>nt :NERDTree<CR>
nnoremap <leader>btr :BookmarkToRoot
" }}}

" CtrlP {{{
" order matching files top to bottom (ttb)
let g:ctrlp_match_window = 'bottom,order:ttb'
" always open files in new buffers
let g:ctrlp_switch_buffer = 0
" change the working directory during a Vim session and make CtrlP respect the change
let g:ctrlp_working_path_mode = 0
" adds speed with ag
let g:ctrlp_user_command = "ag %s -l --nocolor --hidden -g ""'
" }}}

" Tmux {{{
" allows cursor exchange in tmux mode
" without this tmux would use block cursor mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}

" Autogroups {{{
" look at https://dougblack.io/words/a-good-vimrc.html
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    " autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
    "            \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
" }}}

" Backups {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}

" Custom Functions {{{
" toggle between number and relativenumber
function! <SID>ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save the last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
" }}}

" Better display for messages 2
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use `lp` and `ln` for navigate diagnostics
nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>lt <Plug>(coc-type-definition)
nmap <silent> <leader>li <Plug>(coc-implementation)
nmap <silent> <leader>lf <Plug>(coc-references)

" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)

" Use K for show documentation in previous window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" }}}

" VimWiki {{{
let g:vimwiki_list = [{ 'path': '~/Documents/Notes/', 'syntax': 'markdown', 'ext': '.md' }]
" }}}

" Organization
set modelines=1
" vim:foldmethod=marker:foldlevel=0

