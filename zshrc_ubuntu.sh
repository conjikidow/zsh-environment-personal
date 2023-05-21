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

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

function man() { # Displays manual pages with colored output
    LESS_TERMCAP_md=$'\e[01;36m' \
    LESS_TERMCAP_me=$'\e[0m'     \
    LESS_TERMCAP_us=$'\e[01;32m' \
    LESS_TERMCAP_ue=$'\e[0m'     \
    LESS_TERMCAP_so=$'\e[45;93m' \
    LESS_TERMCAP_se=$'\e[0m'     \
    command man "$@"
}

alias open='xdg-open'


# Zsh

export fpath=($fpath $ZDOTDIR/completion)  # Adds the completion directory to the fpath

if [ -x /usr/bin/dircolors ]; then
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}  # Sets the list colors for completion based on LS_COLORS
fi


# C++

export CPATH="${CPATH}:/usr/include/eigen3"


# QT

export QT_QPA_PLATFORM=xcb
