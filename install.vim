""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This vim configuration is not vi compatible
set nocompatible

source $PKG_PATH/autoload/plug.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Manage plugins with vundle

call plug#begin("$PKG_PATH/plugged")

    " Add plugins
    source $PKG_PATH/plugins.vim

    " Add local plugins
    if filereadable($HOME."/.vimrc.plugins")
        source $HOME/.vimrc.plugins
    endif

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Prevent go plugin warnings due to vim version
let g:go_version_warning = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
