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

autoload -Uz bashcompinit
bashcompinit

alias rm='rm -i'  # Prompts for confirmation before removing files
alias mv='mv -i'  # Prompts for confirmation before overwriting files
alias cp='cp -i'  # Prompts for confirmation before overwriting files

alias ll='ls -lhF'  # Lists files using a long listing format with human-readable file sizes
alias la='ls -A'    # Lists almost all files, excluding . and ..
alias lr='ls -R'    # Lists files recursively, including subdirectories

function cd() { # Changes the directory and displays the current directory along with its files and directories
    builtin cd "$@" && ls
}

if [[ -x $(which colordiff) ]]; then
    alias diff='colordiff -u'  # Uses colordiff to display diff with unified format
else
    alias diff='diff -u'       # Uses regular diff to display diff with unified format
fi

function du() { # Displays the disk usage of directories and files
    if [ $# = 0 ]; then
        /usr/bin/du -ah | sort -h
    elif [ $1 = "-h" ] || [ $1 = "--help" ]; then
        echo $'du: show memory used for each directories\n  usage: du [depth number] [directory] \n    depth number: if not entered, show all level \n    directory: if not entered, show all directories'
        return 0
    else
        /usr/bin/du -hd$@ | sort -h
    fi
}

alias shfmt="shfmt -i 4 -ci -sr"


# Zsh

setopt PROMPT_SUBST  # Enables parameter substitution in prompts
source $ZDOTDIR/.git_prompt.sh
export PROMPT='zsh:%F{green}%~%f %F{magenta}$(__git_ps1 "%s" )%f$ '
export RPROMPT='%F{yellow}%w %T%f'

source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -Uz compinit                      # Loads the compinit module
compinit -u                                # Initializes zsh completion

zstyle ':completion:*' auto-description 'specify: %d'                                                  # Specifies the auto-description format for completions
zstyle ':completion:*' completer _oldlist _expand _complete _correct _approximate                      # Specifies the completers for completions
zstyle ':completion:*' group-name ''                                                                   # Sets the group name for completions to empty
zstyle ':completion:*' menu select=2                                                                   # Sets the menu style for completions
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s             # Sets the list prompt format for completions
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'  # Specifies the matchers for completions
zstyle ':completion:*' menu select=long                                                                # Sets the menu style for long completions
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s                     # Sets the select prompt format for completions
zstyle ':completion:*' use-compctl false                                                               # Disables compctl for completions
zstyle ':completion:*' verbose true                                                                    # Enables verbose mode for completions
zstyle ':completion:*' ignore-parents parent pwd ..                                                    # Ignores certain parents for completions
zstyle ':completion:*' insert-tab false                                                                # Disables insert-tab behavior for completions
zstyle ':completion:*:corrections' format '%F{green}%d (errors: %e)%f'                                 # Sets the format for corrections in completions
zstyle ':completion:*:descriptions' format '%B%F{white}--- %d ---%f%b'                                 # Sets the format for descriptions in completions
zstyle ':completion:*:messages' format '%F{yellow}%d'                                                  # Sets the format for messages in completions
zstyle ':completion:*:options' description 'yes'                                                       # Sets the description option for completions
zstyle ':completion:*:warnings' format '%F{red}No matches for: %F{white}%d%b'                          # Sets the format for warnings in completions
zstyle ':completion:*:cd:*' ignore-parents parent pwd                                                  # Ignores certain parents for cd completions
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=00;31'                       # Sets the list colors for kill process completions
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'                        # Specifies the command for kill completions
zstyle ':completion:*:*:git ch:*:*' list-colors '=(#b) #([0-9]#)*=0=00;33'                             # Sets the list colors for git checkout completions

setopt auto_cd            # Enables automatic changing to a directory without typing cd
setopt auto_menu          # Enables automatically displaying the menu on ambiguous completions
setopt auto_param_keys    # Enables automatic parameter expansion when a key is pressed
setopt auto_pushd         # Enables automatic pushing of directories onto the directory stack
setopt brace_ccl          # Enables brace character class expansion
setopt complete_in_word   # Enables completion within a word
setopt correct            # Enables spelling correction
setopt globdots           # Enables matching files starting with a dot without an explicit dot in the pattern
setopt magic_equal_subst  # Enables magic equal substitution
setopt mark_dirs          # Enables marking directories in listings

export HISTSIZE=1000                          # Sets the maximum number of history entries to be saved
export SAVEHIST=10000                         # Sets the maximum number of history entries to be saved in the history file
export HISTTIMEFORMAT="[%Y/%M/%D %H:%M:%S] "  # Sets the format for displaying timestamps in the history

setopt share_history         # Shares history among all running shells
setopt hist_ignore_all_dups  # Ignores duplicate commands in the history
setopt hist_reduce_blanks    # Reduces multiple consecutive blank lines in the history

autoload zmv               # Loads the zmv module for advanced file renaming
alias mmv='noglob zmv -W'  # Defines an alias "mmv" that uses zmv with globbing disabled and extended mode for file renaming


# C++

alias g++="/usr/bin/g++-11 -std=c++20 -Wall -Wextra -Wconversion -pedantic -fsanitize=undefined"
alias gcc="/usr/bin/gcc-11 -std=c99 -Wall -Wextra -fsanitize=undefined"

function cf() { # Format .cpp etc. files
    extensions=("c" "h" "cpp" "hpp" "ipp" "ino" "js")  # Array of file extensions to format
    for file in "$@"; do
        for ext in "${extensions[@]}"; do
            if [ "${file##*.}" = "$ext" ]; then
                clang-format -i "$file"  # Apply clang-format to format the file
                echo "Formatted: $file"
            fi
        done
    done
}

alias make='make -j$[$(grep cpu.cores /proc/cpuinfo | sort -u | sed "s/[^0-9]//g") + 1]'


# Python

if command -v pyenv 1> /dev/null 2>&1; then
    eval "$(pyenv init -)"  # Initializes pyenv
fi

export PYTHONSTARTUP=${ENVDIR}/python/pythonrc.py
alias py='python3'
alias pip='pip3'
alias pip_upgrade="python3 -m pip install --upgrade pip && pip3 list -o | tail -n +3 | awk '{ print $1 }' | xargs pip3 install -U"  # Upgrades pip and installs available package updates
alias -s py=python3                                                                                                                 # Associates the .py file extension with the 'python3' command

function pf() { # Format .py file
    if [ $# = 0 ]; then
        echo $'pf: \e[1;31merror:\e[m\n  usage: pf [option] [python files]'  # Displays an error message if no arguments are provided
        return 0
    fi

    do_sort=0
    if [ $1 = "-h" ] || [ $1 = "--help" ]; then
        echo $'pf: format python files\n  usage: pf [option] [python files]\n    -i, --isort: also sort imports\n    -h, --help: show this help'  # Displays the usage information and options
        echo '  version:\n    '$(autopep8 --version)'\n    '$(yapf --version)
        return 0
    elif [ $1 = "-i" ] || [ $1 = "--isort" ]; then
        do_sort=1
        shift
    fi

    autopep8 -i "$@"  # Formats the Python files using autopep8
    yapf -i "$@"      # Formats the Python files using yapf

    if [ $do_sort = 1 ]; then
        isort "$@"  # Sorts imports in the Python files using isort
    fi
}


# Go

export GOPATH=${HOME}/.go
export PATH="${PATH}:${GOROOT}/bin:${GOPATH}/bin"


# LaTeX

export LATEXDIR=${ENVDIR}/latex
export TEXMFHOME="${LATEXDIR}/texmf"


# Docker

export BUILDKIT_PROGRESS=plain


# VSCode

alias c='code'
