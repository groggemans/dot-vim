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
        autocmd BufNewFile,BufRead *.nomad set ft=hcl ts=2 sw=2
    augroup END

" Terraform files
"
    augroup Terraform
        autocmd!
        autocmd BufNewFile,BufRead *.tf set ft=terraform ts=2 sw=2
    augroup END

" Packer files
"
    augroup HCL
        autocmd!
        autocmd BufNewFile,BufRead *.hcl set ft=hcl ts=2 sw=2
    augroup END

" Jenkins files
"
    augroup Jenkins
        autocmd!
        autocmd BufNewFile,BufRead Jenkinsfile set ft=groovy
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

" NERDCommenter
"
    " Map comment toggle
    nnoremap <Leader>ct <Plug>NERDCommenterToggle

" EasyMotion
"
    let g:EasyMotion_smartcase = 1              " Smart case

    " Improve search
    map  / <Plug>(easymotion-sn)
    omap / <Plug>(easymotion-tn)
    map  n <Plug>(easymotion-next)
    map  N <Plug>(easymotion-prev)

    " Prevent repetitive hjkl
    map <Leader>l <Plug>(easymotion-lineforward)
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
    map <Leader>h <Plug>(easymotion-linebackward)
    let g:EasyMotion_startofline = 0            " Keep cursor column

    " Use f key for EasyMotion
    nmap f <Plug>(easymotion-bd-wl)
    nmap F <Plug>(easymotion-bd-w)

" coc.vim
"
    " coc plugins
    let g:coc_global_extensions = [
        \ 'coc-calc',
        \ 'coc-clangd',
        \ 'coc-css',
        \ 'coc-explorer',
        \ 'coc-git',
        \ 'coc-go',
        \ 'coc-html',
        \ 'coc-json',
        \ 'coc-markdownlint',
        \ 'coc-pyright',
        \ 'coc-sh',
        \ 'coc-snippets',
        \ 'coc-tsserver',
        \ 'coc-yank',
        \ 'coc-yaml',
        \ ]

    nmap <Leader>e <Cmd>CocCommand explorer<CR>

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
    else
    inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Make <CR> auto-select the first completion item and notify coc.nvim to
    " format on enter, <cr> could be remapped by other vim plugin
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    "xmap <leader>f  <Plug>(coc-format-selected)
    "nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Remap <C-f> and <C-b> for scroll float windows/popups.
    if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of language server.
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    "" Mappings for CoCList
    "" Show all diagnostics.
    "nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
    "" Manage extensions.
    "nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
    "" Show commands.
    "nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
    "" Find symbol of current document.
    "nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
    "" Search workspace symbols.
    "nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
    "" Do default action for next item.
    "nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
    "" Do default action for previous item.
    "nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
    "" Resume latest coc list.
    "nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" UltiSnips
"
    "" Auto detect for now
    ""let g:UltiSnipsUsePythonVersion = 2         " Use python 2 for YouCompleteMe
    "let g:UltiSnipsExpandTrigger = "<nop>"
    "let g:ulti_expand_or_jump_res = 0

    "function! ExpandSnippetOrCarriageReturn()
        "let snippet = UltiSnips#ExpandSnippetOrJump()

        "if g:ulti_expand_or_jump_res > 0
            "return snippet
        "else
            "return "\<CR>"
        "endif
    "endfunction

    "inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

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
    "nnoremap <Leader>no :NERDTree<CR>
    "nnoremap <Leader>nq :NERDTreeClose<CR>
    "nnoremap <Leader>nt :NERDTreeToggle<CR>

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

" Vim-GO
"
    let g:go_version_warning = 0

    " disable all linters as that is taken care of by coc.nvim
    let g:go_diagnostics_enabled = 0
    let g:go_metalinter_enabled = []

    " don't jump to errors after metalinter is invoked
    let g:go_jump_to_error = 0

    " run go imports on file save
    let g:go_fmt_command = "goimports"

    " automatically highlight variable your cursor is on
    let g:go_auto_sameids = 0

    " syntax highlighting settings
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_generate_tags = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local config

if filereadable($HOME."/.local/vim/vimrc")
    source $HOME/.local/vim/vimrc
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
