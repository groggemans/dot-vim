""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" @file plugins.vim
" @date Decemeber, 2015
" @author G. Roggemans <g.roggemans@grog.be>
" @copyright Copyright (c) GROG [https://grog.be] 2015, All Rights Reserved
" @license MIT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General tools

" Edit files with sudo
Plug 'chrisbra/sudoedit.vim'

" Repeat for plugin commands
Plug 'tpope/vim-repeat'

" Search tool
Plug 'shougo/unite.vim'

" Tables made easy
Plug 'godlygeek/tabular'

" Tag based navigation
Plug 'Lokaltog/vim-easymotion'

" Acces databases
Plug 'vim-scripts/dbext.vim'

" Syntax checking
Plug 'vim-syntastic/syntastic'

" Highlight trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" Comments made easy
Plug 'scrooloose/nerdcommenter'

" Easy handling of delimiters
Plug 'tpope/vim-surround'

" Auto delimiters
Plug 'raimondi/delimitmate'

" Database integration
Plug 'tpope/vim-db'

" File explorer
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle'] }

" Graphical undo
Plug 'sjl/gundo.vim', { 'on': [ 'Gundo', 'GundoToggle'] }

" Vim table mode
Plug 'dhruvasagar/vim-table-mode', { 'on': ['TableModeToggel', 'TableModeRealign'] }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion

" Auto completer
Plug 'valloric/youcompleteme'

" Complete words from tmux panes
Plug 'wellle/tmux-complete.vim'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets

" Snippets
Plug 'honza/vim-snippets'

" Snippets
Plug 'sirver/ultisnips'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax support

" Better ansible 2.0 support
Plug 'pearofducks/ansible-vim'

" Router OS syntax support
Plug 'zainin/vim-mikrotik'

" Bats syntax support
Plug 'vim-scripts/bats.vim'

" Color code marking
Plug 'lilydjwg/colorizer'

" Puppet syntax support
Plug 'rodjek/vim-puppet'

" Hashicorp tools support
Plug 'hashivim/vim-hashicorp-tools'

" HCL formating
Plug 'fatih/vim-hclfmt'

" Go syntax support
Plug 'fatih/vim-go'

" OpenSCAD support
Plug 'sirtaj/vim-openscad'

" Powershell support
Plug 'PProvost/vim-ps1'

" Markdown and extensions support
Plug 'plasticboy/vim-markdown'

" Arduino support
Plug 'tclem/vim-arduino'

" CFEngine-3 support
Plug 'neilhwatson/vim_cf3'

" toml support
Plug 'cespare/vim-toml'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Interface

" Status bar
Plug 'vim-airline/vim-airline'

" Airline themes
Plug 'vim-airline/vim-airline-themes'

" Prompt line generation
Plug 'edkolev/promptline.vim'

" Buffer line
Plug 'bling/vim-bufferline'

" Indicate line indents
Plug 'yggdroot/indentline'

" Jellybeans color scheme
Plug 'nanotech/jellybeans.vim'

" Add a tagbar to the interface
Plug 'majutsushi/tagbar', { 'on': ['TagbarOpen', 'TagbarToggle'] }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tmux

" Tmux navigation integration
Plug 'christoomey/vim-tmux-navigator'

" Better tmux support
Plug 'tmux-plugins/vim-tmux'

" Fix focus events in tmux
Plug 'tmux-plugins/vim-tmux-focus-events'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git

" Git wrapper plugin
Plug 'tpope/vim-fugitive'

" Gist dependency
Plug 'mattn/webapi-vim'

" Easy gist creation
Plug 'mattn/gist-vim'

" Simple git diff indication
Plug 'airblade/vim-gitgutter'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fixes

" Fix long undo-file names E828
Plug 'pixelastic/vim-undodir-tree'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
