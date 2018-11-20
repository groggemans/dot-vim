##############################################################################
# @file ellipsis.sh
# @date December, 2015
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2015, All Rights Reserved
# @license MIT
##############################################################################

# Minimal ellipsis version
ELLIPSIS_VERSION_DEP='1.9.0'

# Package dependencies (informational/not used!)
ELLIPSIS_PKG_DEPS=''

##############################################################################

pkg.install() {
    # Create vim folders
    mkdir -p "$PKG_PATH"/{undo,swap,spell,autoload,plugged}

    # Install vim-plug
    curl -fLo "$PKG_PATH/autoload/plug.vim" https://raw.github.com/junegunn/vim-plug/master/plug.vim

    # Run vim and install plugins
    PKG_PATH="$PKG_PATH"\
        vim +PlugInstall +qall -u "$PKG_PATH/install.vim"

    # Install YouCompleteMe
    if [ -f "$PKG_PATH/bundle/youcompleteme/install.py" ]; then
        "$PKG_PATH/bundle/youcompleteme/install.py"
    fi
}

##############################################################################

pkg.link() {
    # Link vimrc
    fs.link_file vimrc

    # Link package into ~/.config/vim
    mkdir -p "$ELLIPSIS_HOME/.config"
    fs.link_file "$PKG_PATH" "$ELLIPSIS_HOME/.config/vim"
    fs.link_file "$PKG_PATH" "$ELLIPSIS_HOME/.config/nvim"
}

##############################################################################

pkg.links() {
    local files="$ELLIPSIS_HOME/.config/vim $ELLIPSIS_HOME/.config/nvim $ELLIPSIS_HOME/.vimrc"

    msg.bold "${1:-$PKG_NAME}"
    for file in $files; do
        local link="$(readlink "$file")"
        echo "$(path.relative_to_packages "$link") -> $(path.relative_to_home "$file")";
    done
}

##############################################################################

pkg.pull() {
    # Update dot-vim repo
    git.pull

    # Update plugins (clean than install and update)
    PKG_PATH="$PKG_PATH"\
        vim +PlugClean! +PlugInstall! +qall -u "$PKG_PATH/install.vim"
}

##############################################################################

pkg.unlink() {
    # Remove config dir
    rm "$ELLIPSIS_HOME/.config/vim"
    rm "$ELLIPSIS_HOME/.config/nvim"

    # Remove all links in the home folder
    hooks.unlink
}

##############################################################################

pkg.uninstall() {
    : # No action
}

##############################################################################
