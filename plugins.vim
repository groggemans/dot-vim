""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General tools

" Edit files with sudo
Plug 'chrisbra/sudoedit.vim'

" Repeat for plugin commands
Plug 'tpope/vim-repeat'

" Indenting made easy (unmaintained)
Plug 'godlygeek/tabular'

" Tag based navigation
Plug 'easymotion/vim-easymotion'

" Syntax checking
Plug 'vim-syntastic/syntastic'

" Highlight trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" Comments made easy
Plug 'preservim/nerdcommenter'

" Easy handling of delimiters
Plug 'tpope/vim-surround'

" Auto delimiters
Plug 'jiangmiao/auto-pairs'

" File explorer
"Plug 'preservim/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle'] }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion

" Auto completer
Plug 'neoclide/coc.nvim', { 'branch': 'release'}

" Complete words from tmux panes
Plug 'wellle/tmux-complete.vim'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets

" Snippets
Plug 'honza/vim-snippets'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax support

" Better ansible 2.0 support
Plug 'pearofducks/ansible-vim'

" Router OS syntax support
Plug 'zainin/vim-mikrotik'

" Color code marking
Plug 'lilydjwg/colorizer'

" Hashicorp tools support
Plug 'hashivim/vim-hashicorp-tools'

" HCL syntax support
Plug 'jvirtanen/vim-hcl'

" Go syntax support
Plug 'fatih/vim-go'

" OpenSCAD support
Plug 'sirtaj/vim-openscad'

" Powershell support
Plug 'PProvost/vim-ps1'

" Markdown and extensions support
Plug 'plasticboy/vim-markdown'

" toml support
Plug 'cespare/vim-toml'

" IEC 61131-3
Plug 'jubnzv/IEC.vim'

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fixes

" Fix long undo-file names E828
Plug 'pixelastic/vim-undodir-tree'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
