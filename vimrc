""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" @file vimrc
" @date May, 2015
" @author G. Roggemans <g.roggemans@grog.be>
" @copyright Copyright (c) GROG [https://grog.be] 2015, All Rights Reserved
" @license MIT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This vim configuration is not vi compatible
set nocompatible

" Add custom config dir to (the front of) the runtime path
exec "set rtp=$HOME/.config/vim," . &rtp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Manage plugins with vim-plug

call plug#begin($HOME."/.config/vim/plugged")

    " Add plugins
    source $HOME/.config/vim/plugins.vim

    " Add local plugins
    if filereadable($HOME."/.local/vim/plugins.vim")
        source $HOME/.local/vim/plugins.vim
    endif

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings

syntax on                                   " Enable syntax highlighting

set encoding=utf-8                          " Enforce UTF-8 encoding
set termencoding=utf-8
set fileencoding=utf-8

set history=1000                            " Make undo history larger
set autoread                                " Refresh if changed
set noautowrite                             " Do not auto write
set nobackup                                " Do not make *~ backup file

set confirm                                 " Prompt when exiting unsaved file
set mouse=                                  " Disable mouse

set autoindent                              " Enable auto indentation
set cinkeys-=0#                             " Don't force # indentation

set tabstop=4                               " Tab is 4 spaces
set softtabstop=4                           " Backspace
set shiftwidth=4                            " Indentation is 4 spaces
set expandtab                               " Expand tab to spaces
set smarttab                                " Tab to 0,4,8,...
set shiftround                              " Smart tabs

set iskeyword+=_,$,@,%,#                    " These are not word dividers
set backspace=indent,eol,start              " Smart backspace
set incsearch                               " Incremental search
set ignorecase                              " Ignore case
set smartcase                               " Sensitive with uppercase

set wildignore=*.a,*.o,*.so,*.pyc,*.jpg,
            \*.jpeg,*.png,*.gif,*.pdf,*.git,
            \*.swp,*.swo                    " Tab completion ignores
set wildmenu                                " Better auto complete
set wildmode=longest,list                   " Bash-like auto complete

" Return to last edit position when opening files
augroup LastPosition
    autocmd! BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     exe "normal! g`\"" |
        \ endif
augroup END

" Enable persistent undos
if has('persistent_undo') && exists("&undodir")
    set undodir=$HOME/.config/vim/undo//    " Location of undofiles
    set undofile                            " Enable undofile
    set undolevels=500                      " Max undos stored
    set undoreload=10000                    " Buffer stored undos
endif

" Place swap files in dedicated place
if !strlen($SUDO_USER)
    set directory^=$HOME/.config/vim/swap// " Default cwd, // full path
    set swapfile                            " Enable swap files
    set updatecount=50                      " Update swp after 50chars
    " Don't swap tmp, mount or network dirs
    augroup SwapIgnore
        autocmd! BufNewFile,BufReadPre /tmp/*,/mnt/*,/media/*
                \ setlocal noswapfile
    augroup END
else
    set noswapfile                          " Don't swap root files
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Interface settings

set ttyfast                                 " Faster redraws

set cursorline                              " Highlight cursor line
set showcmd                                 " Show commands being typed
set scrolloff=5                             " Lines below/above cursor

set showmatch                               " Show matching bracket
set matchtime=2                             " Show for 0.2 seconds
set matchpairs+=<:>                         " Match pair for html

set title                                   " Show window title
set number                                  " Add line numbers
set laststatus=2                            " Show status line

set nofoldenable                            " Disable folding
set nowrap                                  " Disable line wrapping
set linebreak                               " Don't cut words on wrap

set splitbelow                              " Split below with focus
set splitright                              " Vsplit right with focus

set background=dark                         " Use a dark background
set t_Co=256                                " Use 256 terminal colors
colorscheme jellybeans                      " Use the jellybeans color scheme


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings

" Faster commands
nnoremap ; :

" Make <Space> leader
nnoremap <Space> <Nop>
let mapleader="\<Space>"

" Disable F1
inoremap <F1> <Nop>
nnoremap <F1> <Nop>
vnoremap <F1> <Nop>

" Disable ex mode
map Q <Nop>

" Treat wrapped lines as normal lines
nnoremap j gj
nnoremap k gk

" Map scrolling to ctrl-j/k
nnoremap J <C-d>
nnoremap K <C-u>

" Map help to H
nnoremap H K

" Map join lines to L
nnoremap L J

" Easier navigation between split windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Quick vimrc editing <L>ve and reloading <L>vr
noremap <Leader>ve :edit $HOME/.vimrc<CR>
noremap <Leader>vr :source $HOME/.vimrc<CR>

" Stay in visual mode when indenting
vnoremap < <gv
vnoremap > >gv

" User Tab and Shift-Tab for indentation in visual mode
vmap <Tab> >
vmap <S-Tab> <

" Spell checking shortcuts
nnoremap <Leader>seu :set spell spelllang=en_us<CR>
nnoremap <Leader>seg :set spell spelllang=en_gb<CR>
nnoremap <Leader>snl :set spell spelllang=nl<CR>
nnoremap <Leader>sq :set nospell<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom commands

" Correct little mistakes
command! W w
command! Q q
command! WQ wq
command! Wq wq
command! QA qa
command! Qa qa


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fancy bindings and functions

" Add copy and paste to system clipboard (prefer system tools)
function! ClipboardYank()
    if executable('xclip')
        call system('xclip -i -selection clipboard', @@)
    elseif executable('pbcopy')
        call system('pbcopy', @@)
    elseif has('clipboard')
        let @+ = @@
    else
        errormsg "No system clipboard tool found!"
    endif
endfunction

function! ClipboardPaste()
    if executable('xclip')
        let @@ = system('xclip -o -selection clipboard')
    elseif executable('pbcopy')
        let @@ = system('pbpaste')
    elseif has('clipboard')
        let @@ = @+
    else
        errormsg "No system clipboard tool found!"
    endif
endfunction

noremap <leader>y y:call ClipboardYank()<cr>
noremap <Leader>Y Y:call ClipboardYank()<cr>
noremap <leader>d d:call ClipboardYank()<cr>
noremap <leader>D D:call ClipboardYank()<cr>
noremap <leader>p :call ClipboardPaste()<cr>p
noremap <Leader>P :call ClipboardPaste()<cr>P

" Toggle highlighting of characters past 79 chars
let g:overlength_enabled = 0
highlight OverLength ctermbg=238 guibg=#444444

function! ToggleOverLength()
    if g:overlength_enabled == 0
        match OverLength /\%79v.*/
        let g:overlength_enabled = 1
        echo 'OverLength highlighting turned on'
    else
        match
        let g:overlength_enabled = 0
        echo 'OverLength highlighting turned off'
    endif
endfunction

nnoremap <leader>e :call ToggleOverLength()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type specific settings

" Text files
"
    augroup TextFileRules
        autocmd!
        autocmd BufNewFile,BufRead *.md set ft=markdown tw=79
        autocmd BufNewFile,BufRead *.tex set ft=tex tw=79
        autocmd BufNewFile,BufRead *.txt set ft=sh tw=79
    augroup END

" Git
"
    augroup GitFileRules
        autocmd!
        autocmd BufNewFile,BufRead COMMIT_EDITMSG set ft=gitcommit
        autocmd FileType gitcommit set spell spelllang=en_us
    augroup END

" C/C++
"
    augroup CCppFileRules
        autocmd!
        " Only auto-comment newline for block comments
        autocmd FileType c,cpp setlocal comments -=:// comments +=f://
    augroup END

" PHP
"
    let php_sql_query=1
    let php_htmlInStrings=1

" HTML
"
    augroup HtmlFileRules
        autocmd!
        autocmd FileType html setlocal ts=2 sw=2
        autocmd BufNewFile,BufRead *.blade.php set ft=html
    augroup END

" Jinja
"
    augroup YamlFileRules
        autocmd!
        autocmd FileType yml,yaml setlocal ts=2 sts=2 sw=2
    augroup END

" Makefiles
"
    augroup Makefiles
        autocmd!
        autocmd FileType make set noexpandtab
    augroup END


" Nomad files
"
    augroup Nomad
        autocmd!
        " Force hcl syntax through terraform plugin
        autocmd BufNewFile,BufRead *.nomad set ft=terraform
    augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings

" Promptline
"
    let g:promptline_powerline_symbols = 0      " Disable special symbols

    " Custom promptline preset
    let g:promptline_preset = {
        \'a' : [ promptline#slices#user() ],
        \'b' : [ promptline#slices#cwd() ],
        \'c' : [ promptline#slices#vcs_branch(), promptline#slices#jobs() ],
        \'warn' : [ promptline#slices#last_exit_code() ]}

" OmniCompletion
"
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType c setlocal omnifunc=ccomplete#Complete
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.php =
    \ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
    let g:neocomplete#sources#omni#input_patterns.c =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
    let g:neocomplete#sources#omni#input_patterns.cpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" DelimitMate
"
    " Change Backspace behavior
    imap <BS> <Plug>delimitMateS-BS

" NERDCommenter
"
    " Map comment toggle
    nnoremap <Leader>ct <Plug>NERDCommenterToggle

" Gundo
"
    " Map window togel
    nnoremap <Leader>u :GundoToggle<CR>

    let g:gundo_width = 45                      " Window width
    let g:gundo_preview_bottom = 1              " Preview on the bottom
    let g:gundo_preview_height = 15             " Window height
    let g:gundo_right = 1                       " Right side
    let g:gundo_close_on_revert = 1             " Close after revert

" EasyMotion
"
    let g:EasyMotion_smartcase = 1              " Smart case

    " Improve search
    map  / <Plug>(easymotion-sn)
    omap / <Plug>(easymotion-tn)
    map  n <Plug>(easymotion-next)
    map  m <Plug>(easymotion-prev)

    " Prevent repetitive hjkl
    map <Leader>l <Plug>(easymotion-lineforward)
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
    map <Leader>h <Plug>(easymotion-linebackward)
    let g:EasyMotion_startofline = 0            " Keep cursor column

    " Use f key for EasyMotion
    nmap f <Plug>(easymotion-bd-wl)
    nmap F <Plug>(easymotion-bd-w)

" UltiSnips
"
    " Auto detect for now
    "let g:UltiSnipsUsePythonVersion = 2         " Use python 2 for YouCompleteMe
    let g:UltiSnipsExpandTrigger = "<nop>"
    let g:ulti_expand_or_jump_res = 0

    function! ExpandSnippetOrCarriageReturn()
        let snippet = UltiSnips#ExpandSnippetOrJump()

        if g:ulti_expand_or_jump_res > 0
            return snippet
        else
            return "\<CR>"
        endif
    endfunction

    inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

" YouCompleteMe
"
    " Enable completion in comments
    let g:ycm_complete_in_comments = 1

    " Collect from strings and comments
    let g:ycm_collect_identifiers_from_comments_and_strings = 1

    " Collect from tag files
    let g:ycm_collect_identifiers_from_tags_files = 1

    " Seed keywords for file type
    let g:ycm_seed_identifiers_with_syntax = 1

    " Auto close preview
    let g:ycm_autoclose_preview_window_after_completion = 1

" Vim Tmux Navigator
"
    autocmd FocusGained * silent redraw!             " Fix artifacts

" Tmux Complete
"
    let g:tmuxcomplete#trigger = 'omnifunc'     " Completion trigger

" Airline
"
    " Separators
    let g:airline_left_sep=''
    let g:airline_right_sep=''

    " Use the correct theme
    let g:airline_theme='jellybeans'

    " Whitespace detection
    let g:airline#extensions#whitespace#enabled = 1

" NERDTree
"
    " Map NERDTree open, close and toggle
    nnoremap <Leader>no :NERDTree<CR>
    nnoremap <Leader>nq :NERDTreeClose<CR>
    nnoremap <Leader>nt :NERDTreeToggle<CR>

" GitGutter
"
    let g:gitgutter_map_keys = 0                " No default mappings

    " Jump to next and previous hunk
    nmap ]h <Plug>GitGutterNextHunk
    nmap [h <Plug>GitGutterPrevHunk

    " Add or revert the current hunk
    nmap <Leader>ha <Plug>GitGutterStageHunk
    nmap <Leader>hu <Plug>GitGutterRevertHunk

    " Preview changes
    nmap <Leader>hp <Plug>GitGutterPreviewHunk

" IndentLine
"
    " File types to enable indentation lines for
    let g:indentLine_fileType = ['c', 'cpp', 'php', 'h']
    let g:indentLine_faster = 1

" TagBar
"
    let g:tagbar_width = 30                     " Make TagBar smaller

    " Map TagBar open/focus, close, toggle and open in auto close mode
    nnoremap <Leader>to :TagbarOpen fj<CR>
    nnoremap <Leader>tq :TagbarClose<CR>
    nnoremap <Leader>tt :TagbarToggle<CR>
    nnoremap <Leader>ta :TagbarOpenAutoClose<CR>

" Table Mode
"
    let g:table_mode_corner = '|'
    let g:table_mode_disable_mappings = 1
    nnoremap <Leader>tm :TableModeToggle <CR>
    nnoremap <Leader>tr :TableModeRealign <CR>

" Vim-GO
"
    let g:go_version_warning = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local config

if filereadable($HOME."/.local/vim/vimrc")
    source $HOME/.local/vim/vimrc
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
