# My personal zsh configuration file
# Copyright (C) 2023 conjikidow
#
# This program is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.


# Bash

alias ls='ls -G'                        # Displays colored list
export LSCOLORS=Gxfxcxdxfxegedabagacad  # Sets the LSCOLORS environment variable to change the color when using 'ls'

function cdf() { # Changes to the directory of the frontmost Finder window
    target=$(osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
    if [ "$target" != "" ]; then
        cd "$target"
    else
        echo 'No Finder window found' 1>&2
    fi
}

function search() { # Searches files or directories
    if [ $# -eq 0 ]; then
        echo $'search: \e[1;31merror:\e[m\n  usage: search [option] [file or directory name]'
        return 0
    elif [ $1 = "-h" ] || [ $1 = "--help" ]; then
        echo $'search: search for files or directories\n  usage: search [option] [file or directory name]'
        echo '    -e, --exact: search files or directories only whoes names match exactly\n                 (wild card * can be used with quotation marks "")'
        echo '    -h, --help: show this help'
        return 0
    elif [ $1 = "-e" ] || [ $1 = "--exact" ]; then
        shift
        args=($@)
        shift
        /usr/bin/mdfind 'kMDItemFSName == '$args[1]'' $@
    else
        args=($@)
        shift
        /usr/bin/mdfind -name $args[1] $@
    fi
}

alias rmds="find . -name '*.DS_Store' -type f -delete"  # Removes .DS_store recursively


# Zsh

FPATH=$(brew --prefix)/share/zsh-completions:$FPATH  # Adds the completion directory to the fpath

zstyle ':completion:*' list-colors 'di=1;36' 'ln=35' 'so=32' 'ex=35' 'bd=46;34' 'cd=43;34'  # Customizes completion colors for different types of completions
