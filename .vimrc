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
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'ternjs/tern_for_vim'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 ./install.py --tern-completer' }
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
autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
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
" space open/closes folds
" legend has it that z is used in vim for folds
"     because it looks like a fold
nnoremap <space> za
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
let mapleader=","
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

" Tern {{{
" Start autocompletion after 4 chars
" let g:ycm_min_num_of_chars_for_completion = 4
"let g:ycm_min_num_identifier_candidate_chars = 4
"let g:ycm_enable_diagnostic_highlighting = 0 " Don't show YCM's preview window [ I find it really annoying ]
"set completeopt-=preview
"let g:ycm_add_preview_to_completeopt = 0
" let g:tern#is_show_argument_hints_enabled = 1
"}}}

" VimWiki {{{
let g:vimwiki_list = [{ 'path': '~/Documents/Notes/', 'syntax': 'markdown', 'ext': '.md' }]
" }}}

" Organization
set modelines=1
" vim:foldmethod=marker:foldlevel=0

