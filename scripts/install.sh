#!/usr/bin/env bash
set -e

# Installation file for Software-Install-Guides
## Not installing the documentation itself, but the `Sphinx-Docs` program parts
## that you need to build the docs.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ "$(uname)" == "Linux" ]]; then
    if [[ -n "$(command -v pip3)" ]]; then
        PIPBIN="$(command -v pip3)"
    fi
else
    if [[ -n "$(command -v pip3)" ]]; then
        PIPBIN="$(command -v pip3)"
    fi
fi

SUDO="$(command -v sudo)"

"${SUDO}" -H "${PIPBIN}" install --upgrade -r "${DIR}/requirements.txt"
