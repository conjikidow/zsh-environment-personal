# Useful zsh configuration file
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


# Zsh

export ZDOTDIR="${HOME}/.zsh"
export HISTFILE="${ZDOTDIR}/.zsh_history"


# Python

export PYENV_ROOT="${HOME}/.python/pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
