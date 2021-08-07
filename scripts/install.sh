#!/usr/bin/env bash
set -e

# Installation file for Software-Install-Guides
## Not installing the documentation itself, but the `Sphinx-Docs` program parts
## that you need to build the docs.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ ! -e "${DIR}/../venv" ]]; then
    virtualenv "${DIR}/../venv"
fi

source "${DIR}/../venv/bin/activate"

"${DIR}/../venv/bin/pip3" install --upgrade -r "${DIR}/requirements.txt"
