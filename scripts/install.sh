#!/usr/bin/env bash
set -e

# Installation file for Software-Install-Guides
## Not installing the documentation itself, but the `Sphinx-Docs` program parts
## that you need to build the docs.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#if [[ "$(command -v virtualenv)" ]]; then
#    if [[ ! -e "${DIR}/../venv" ]]; then
#        virtualenv "${DIR}/../venv"
#    fi
#else
#    echo "Looks like 'virtualenv' is missing from your computer..."
#    echo "Please, install that program, first!"
#    echo "Thanks, and have a grand day!"
#    exit
#fi

#source "${DIR}/../venv/bin/activate"
#
#"${DIR}/../venv/bin/pip3" install --upgrade -r "${DIR}/../requirements.txt"

pip3 install --upgrade pip
pip3 install -U pipenv

$(command -v pipenv) install
